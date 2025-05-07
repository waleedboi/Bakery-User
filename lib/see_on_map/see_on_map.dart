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

  List<Map<String, dynamic>> bakeries = [];

  @override
  void initState() {
    super.initState();
    fetchBakeryData();
  }

  Future<void> fetchBakeryData() async {
    final snapshot = await FirebaseFirestore.instance.collection('admins').get();
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
      bakeries = bakeryList;
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
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(bakery['id']),
              position: newPosition,
              infoWindow: InfoWindow(title: bakery['bakeryName']),
            ),
          );
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
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            onMapCreated: (controller) => _mapController.complete(controller),
            markers: _markers,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            height: 100,
            child: SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: bakeries.length,
                itemBuilder: (context, index) {
                  final bakery = bakeries[index];
                  return GestureDetector(
                    onTap: () => _onBakeryTap(bakery),
                    child: Container(
                      width: 280,
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
                          Flexible(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: bakery['bakeryImage'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bakery['bakeryName'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  bakery['bakeryLocation'],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
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
          ),
        ],
      ),
    );
  }
}
