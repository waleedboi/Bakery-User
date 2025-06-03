import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeeOnMapScreen extends StatefulWidget {
  const SeeOnMapScreen({super.key});

  @override
  State<SeeOnMapScreen> createState() => _SeeOnMapScreenState();
}

class _SeeOnMapScreenState extends State<SeeOnMapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final LatLng _initialPosition = const LatLng(30.1575, 71.5249);
  final Set<Marker> _markers = {};

  List<Map<String, dynamic>> _allBakeries = [];
  List<Map<String, dynamic>> _filteredBakeries = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBakeryData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredBakeries = List.from(_allBakeries);
      } else {
        _filteredBakeries = _allBakeries
            .where((b) =>
                (b['bakeryName'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  Future<void> fetchBakeryData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('admins').get();
    final List<Map<String, dynamic>> bakeryList = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data.containsKey('bakeryLatLng')) {
        bakeryList.add({
          'id': doc.id,
          'bakeryName': data['bakeryName'] ?? '',
          'bakeryImage': data['bakeryImage'] ?? '',
          'bakeryLocation': data['bakeryLocation'] ?? '',
          'bakeryLatLng': data['bakeryLatLng'],
        });
      }
    }

    setState(() {
      _allBakeries = bakeryList;
      _filteredBakeries = List.from(bakeryList);
    });
  }

  void _onBakeryTap(Map<String, dynamic> bakery) async {
    final latLngString = bakery['bakeryLatLng'];
    final parts = latLngString.split(',');
    if (parts.length == 2) {
      final lat = double.tryParse(parts[0]);
      final lng = double.tryParse(parts[1]);
      if (lat != null && lng != null) {
        final newPosition = LatLng(lat, lng);

        final controller = await _mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(newPosition));

        setState(() {
          _markers
            ..clear()
            ..add(Marker(
              markerId: MarkerId(bakery['id']),
              position: newPosition,
              infoWindow: InfoWindow(title: bakery['bakeryName']),
            ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 12),
            onMapCreated: (ctrl) => _mapController.complete(ctrl),
            markers: _markers,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          // Search field
          Positioned(
            top: 115,
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              height: 53,
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.grey,
                onChanged: (_) => null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 10.0),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      const Image(image: AssetImage("images/Layer 2.png")),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: Color(0xff4B4B4B),
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 202, 202, 202)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 202, 202, 202)),
                  ),
                ),
              ),
            ),
          ),
          // Bakery list
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredBakeries.length,
              itemBuilder: (context, index) {
                final bakery = _filteredBakeries[index];
                return GestureDetector(
                  onTap: () => _onBakeryTap(bakery),
                  child: Container(
                    width: 320,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: bakery['bakeryImage'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                const CircularProgressIndicator(),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bakery['bakeryName'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                bakery['bakeryLocation'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
