import 'dart:io';
import 'package:completefoodorderingappui/bakeryadminapp/admin_bottom_bar/admin_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBakery extends StatefulWidget {
  const RegisterBakery({super.key});

  @override
  State<RegisterBakery> createState() => _RegisterBakeryState();
}

class _RegisterBakeryState extends State<RegisterBakery> {
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
  String? _imageUrl;
  bool _isLoading = false;
  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
  
  bool _validateLatLng() {
    if (_latitudeController.text.isEmpty || _longitudeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both latitude and longitude')),
      );
      return false;
    }
    
    try {
      double lat = double.parse(_latitudeController.text);
      double lng = double.parse(_longitudeController.text);
      
      if (lat < -90 || lat > 90) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Latitude must be between -90 and 90')),
        );
        return false;
      }
      
      if (lng < -180 || lng > 180) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Longitude must be between -180 and 180')),
        );
        return false;
      }
      
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numeric values for latitude and longitude')),
      );
      return false;
    }
  }
  
  Future<void> _uploadImageAndSaveBakeryInfo() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      // Upload image
      String? downloadUrl;
      if (_imageFile != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance.ref().child('bakery_images/$fileName');
        UploadTask uploadTask = storageRef.putFile(_imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask;
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
      }

      String bakeryLatLng = "${_latitudeController.text.trim()},${_longitudeController.text.trim()}";

      // Save to Firestore
      await FirebaseFirestore.instance.collection('admins').doc(user.uid).update({
        'bakeryName': _bakeryNameController.text.trim(),
        'bakeryDescription': _bakeryDescriptionController.text.trim(),
        'bakeryTiming': _bakeryTiming,
        if (downloadUrl != null) 'bakeryImage': downloadUrl,
        'bakeryLocation': _bakeryLocationController.text.trim(),
        'bakeryLatLng': bakeryLatLng,
        'bakeryRating': 0,
        'stripePublishableKey': _publishableKeyController.text.trim(),
        'stripeSecretKey': _secretKeyController.text.trim(),
        'stripeAccountId': _accountIdController.text.trim(),
        'hasStripeSetup': true,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminBottomBarScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering bakery: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Your Bakery'),
        backgroundColor: const Color(0xffEEEEE6),
      ),
      body: Form(
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
                  onPressed: _isLoading ? null : _uploadImageAndSaveBakeryInfo,
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
                          'Register Bakery',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Note: You can find Stripe details in your Stripe Dashboard under Developers > API Keys.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}