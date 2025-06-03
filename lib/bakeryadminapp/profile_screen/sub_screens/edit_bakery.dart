import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditBakeryScreen extends StatefulWidget {
  const EditBakeryScreen({super.key});

  @override
  State<EditBakeryScreen> createState() => _EditBakeryScreenState();
}

class _EditBakeryScreenState extends State<EditBakeryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bakeryNameController = TextEditingController();
  final _bakeryDescriptionController = TextEditingController();
  final _bakeryLocationController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _publishableKeyController = TextEditingController();
  final _secretKeyController = TextEditingController();
  final _accountIdController = TextEditingController();
  
  TimeOfDay _openingTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _closingTime = const TimeOfDay(hour: 20, minute: 0);
  String _bakeryTiming = "09:00 - 20:00";
  
  File? _imageFile;
  String? _currentImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBakeryData();
  }

  Future<void> _loadBakeryData() async {
    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        
        setState(() {
          _bakeryNameController.text = data['bakeryName'] ?? '';
          _bakeryDescriptionController.text = data['bakeryDescription'] ?? '';
          _bakeryLocationController.text = data['bakeryLocation'] ?? '';
          _currentImageUrl = data['bakeryImage'];
          _publishableKeyController.text = data['stripePublishableKey'] ?? '';
          _secretKeyController.text = data['stripeSecretKey'] ?? '';
          _accountIdController.text = data['stripeAccountId'] ?? '';
          
          final latLng = (data['bakeryLatLng'] as String?)?.split(',');
          if (latLng != null && latLng.length == 2) {
            _latitudeController.text = latLng[0];
            _longitudeController.text = latLng[1];
          }
          
          final timing = data['bakeryTiming'] as String?;
          if (timing != null) {
            _bakeryTiming = timing;
            final times = timing.split(' - ');
            if (times.length == 2) {
              _openingTime = _parseTimeString(times[0]);
              _closingTime = _parseTimeString(times[1]);
            }
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading bakery data: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  TimeOfDay _parseTimeString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> _selectOpeningTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _openingTime,
    );
    
    if (picked != null) {
      setState(() {
        _openingTime = picked;
        _bakeryTiming = "${_formatTimeOfDay(_openingTime)} - ${_formatTimeOfDay(_closingTime)}";
      });
    }
  }

  Future<void> _selectClosingTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _closingTime,
    );
    
    if (picked != null) {
      setState(() {
        _closingTime = picked;
        _bakeryTiming = "${_formatTimeOfDay(_openingTime)} - ${_formatTimeOfDay(_closingTime)}";
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      String? downloadUrl;
      if (_imageFile != null) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = FirebaseStorage.instance.ref().child('bakery_images/$fileName');
        final uploadTask = storageRef.putFile(_imageFile!);
        final taskSnapshot = await uploadTask;
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
      }

      final bakeryLatLng = "${_latitudeController.text.trim()},${_longitudeController.text.trim()}";

      await FirebaseFirestore.instance.collection('admins').doc(user.uid).update({
        'bakeryName': _bakeryNameController.text.trim(),
        'bakeryDescription': _bakeryDescriptionController.text.trim(),
        'bakeryTiming': _bakeryTiming,
        if (downloadUrl != null) 'bakeryImage': downloadUrl,
        'bakeryLocation': _bakeryLocationController.text.trim(),
        'bakeryLatLng': bakeryLatLng,
        'stripePublishableKey': _publishableKeyController.text.trim(),
        'stripeSecretKey': _secretKeyController.text.trim(),
        'stripeAccountId': _accountIdController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bakery details updated successfully')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating bakery details: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      appBar: AppBar(
        title: const Text('Edit Bakery Details'),
        backgroundColor: const Color(0xffEEEEE6),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120.h,
                            height: 120.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: _imageFile != null
                                ? ClipOval(
                                    child: Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _currentImageUrl != null
                                    ? ClipOval(
                                        child: Image.network(
                                          _currentImageUrl!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                        loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Icon(
                                        Icons.store,
                                        size: 50.sp,
                                        color: Colors.grey[600],
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xff1B4332),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _bakeryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Bakery Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter bakery name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _bakeryDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter bakery description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _bakeryLocationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter bakery location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _latitudeController,
                            decoration: const InputDecoration(
                              labelText: 'Latitude',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: TextFormField(
                            controller: _longitudeController,
                            decoration: const InputDecoration(
                              labelText: 'Longitude',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: _selectOpeningTime,
                            icon: const Icon(Icons.access_time),
                            label: Text('Opening Time: ${_formatTimeOfDay(_openingTime)}'),
                          ),
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: _selectClosingTime,
                            icon: const Icon(Icons.access_time),
                            label: Text('Closing Time: ${_formatTimeOfDay(_closingTime)}'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      'Stripe Account Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: _publishableKeyController,
                      decoration: const InputDecoration(
                        labelText: 'Publishable Key',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter publishable key';
                        }
                        if (!value!.startsWith('pk_')) {
                          return 'Invalid publishable key format';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _secretKeyController,
                      decoration: const InputDecoration(
                        labelText: 'Secret Key',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter secret key';
                        }
                        if (!value!.startsWith('sk_')) {
                          return 'Invalid secret key format';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _accountIdController,
                      decoration: const InputDecoration(
                        labelText: 'Account ID',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter account ID';
                        }
                        if (!value!.startsWith('acct_')) {
                          return 'Invalid account ID format';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1B4332),
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Save Changes',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 