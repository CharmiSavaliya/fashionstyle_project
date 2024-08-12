import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_project/auth_service.dart';
import 'package:fashion_project/bottomnavigationbar.dart';
import 'package:fashion_project/sign_in_screen.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? name = '';
  String? phoneNumber = '';
  String? countryCode = 'US';
  String? imageUrl;
  File? _image;
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    Map<String, dynamic>? userProfile = await _authService.getUserProfile();
    if (userProfile != null) {
      setState(() {
        name = userProfile['name'] ?? '';
        phoneNumber = userProfile['phoneNumber'] ?? '';
        selectedGender = userProfile['gender'];
        countryCode = userProfile['countryCode'] ?? 'US';
        imageUrl = userProfile['imageUrl'];

        _nameController.text = name!;
        _phoneController.text = phoneNumber!;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String? newImageUrl;
        if (_image != null) {
          newImageUrl = await _uploadImage(_image!);
        } else {
          newImageUrl = imageUrl;
        }
        await _authService.updateUserProfile(
          _nameController.text,
          _phoneController.text,
          selectedGender!,
          countryCode ?? 'US',
          imageUrl: newImageUrl,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  Future<String> _uploadImage(File image) async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef = FirebaseStorage.instance.ref().child('profile_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(image);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', false);
    await _authService.signout();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile Screen',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigationbarScreen()),
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry, only you can see your personal data. No one else will be able to see it.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: const Color(0xffE6E6E6),
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : const AssetImage('assets/default_profile_image.png')) as ImageProvider,
                      child: _image == null && imageUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          final source = await showDialog<ImageSource>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select Image Source'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, ImageSource.camera);
                                  },
                                  child: const Text('Camera'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, ImageSource.gallery);
                                  },
                                  child: const Text('Gallery'),
                                ),
                              ],
                            ),
                          );
                          if (source != null) {
                            _pickImage(source);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  initialCountryCode: countryCode,
                  onChanged: (phone) {
                    setState(() {
                      phoneNumber = phone.completeNumber;
                      countryCode = phone.countryCode;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.completeNumber.isEmpty) {
                      return 'Phone Number cannot be empty';
                    } else if (value.completeNumber.length < 8) {
                      return 'Phone Number must be at least 8 digits';
                    }
                    return null;
                  },
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Select',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    selectedGender = value;
                  },
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                    backgroundColor: Colors.brown,
                  ),
                  child: const Text(
                    'Complete Profile',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                    backgroundColor: Colors.brown,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
