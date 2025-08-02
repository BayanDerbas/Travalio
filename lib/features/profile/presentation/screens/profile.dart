import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:travalio/core/constants/app_colors.dart';
import 'package:travalio/features/discover/presentation/bloc/navigation_bar_bottom/navigation_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/secure_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserInfoFromToken();
  }

  Future<void> _loadUserInfoFromToken() async {
    final storage = SecureStorage();
    final token = await storage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      final decodedToken = JwtDecoder.decode(token);

      setState(() {
        _username = decodedToken['username'] ?? 'Unknown';
        _email = decodedToken['email'] ?? 'Unknown';
      });

      print('[Profile] username: $_username');
      print('[Profile] email: $_email');
    } else {
      print('[Profile] No access token found.');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  padding:  EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepOrange, Colors.orange],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Icon(Icons.search, color: Colors.white),
                          Text(
                            'Personal Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon:Icon(Icons.notifications),
                            color: AppColors.white,
                            onPressed: () {
                              context.push(AppRoutes.notification);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -45,
                  left: 0,
                  right: 0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const AssetImage('assets/images/avatar.png') as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 155,
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 2,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 22, color: AppColors.smooky),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildProfileRow(Icons.person, _username ?? 'User full name'),
                  _buildProfileRow(Icons.date_range, '8/8/2020'),
                  _buildProfileRow(Icons.email, _email ??  'abdullahalkabbani.2002@gmail.com'),
                  _buildProfileRow(Icons.lock, 'Edit Your Password',
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16)),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'LOG OUT',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            title: const Text('Log out',),
                            content: const Text('Are you sure you want to log out of the Travalio app?'),
                            actions: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.grey),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'No, thank you',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.go(AppRoutes.login);
                                },
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileRow(IconData icon, String text, {Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppColors.deepOrange),
          title: Text(text),
          trailing: trailing ?? const Icon(Icons.edit, size: 18, color: AppColors.smooky),
        ),
        const Divider(),
      ],
    );
  }
}
