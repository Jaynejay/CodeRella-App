import 'package:flutter/material.dart';
import 'homepage.dart';
import 'add_submission_page.dart';
import 'notification_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController(text: 'Dinux Fernando');
  final TextEditingController phoneController = TextEditingController(text: '0711234567');
  final TextEditingController emailController = TextEditingController(text: 'abcd@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'password');

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showProfilePictureOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF1A3C6B)),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF1A3C6B)),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.remove_red_eye, color: Color(0xFF1A3C6B)),
                  title: const Text('See profile picture'),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_profileImage!, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2F0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Blue curved header
                ClipPath(
                  clipper: ProfileCurveClipper(),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A3C6B), Color(0xFF3B6BA5)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          nameController.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Back arrow
                Positioned(
                  top: 36,
                  left: 12,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                  ),
                ),
                // Profile picture (overlapping curve) with camera icon always visible
                Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: _showProfilePictureOptions,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: _profileImage == null
                                ? const Icon(Icons.person, size: 60, color: Color(0xFF1A3C6B))
                                : ClipOval(
                                    child: Image.file(
                                      _profileImage!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: _showProfilePictureOptions,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A3C6B),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isEditing) ...[
                    _staticProfileInfoRow(Icons.person_outline, nameController.text),
                    const SizedBox(height: 18),
                    _staticProfileInfoRow(Icons.phone_outlined, phoneController.text),
                    const SizedBox(height: 18),
                    _staticProfileInfoRow(Icons.email_outlined, emailController.text),
                    const SizedBox(height: 18),
                    _staticProfileInfoRow(Icons.remove_red_eye_outlined, passwordController.text),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3C6B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.2),
                        ),
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
                        },
                        child: const Text('Edit Profile', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                  if (isEditing) ...[
                    _buildProfileField(icon: Icons.person_outline, controller: nameController, label: 'Name'),
                    const SizedBox(height: 18),
                    _buildProfileField(icon: Icons.phone_outlined, controller: phoneController, label: 'Phone', keyboardType: TextInputType.phone),
                    const SizedBox(height: 18),
                    _buildProfileField(icon: Icons.email_outlined, controller: emailController, label: 'Email', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 18),
                    _buildProfileField(icon: Icons.remove_red_eye_outlined, controller: passwordController, label: 'Password', obscureText: true),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3C6B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.2),
                        ),
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                        child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF7F2F0),
        child: buildBottomNavBar(context, 3),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF1A3C6B), size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF1A3C6B)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF1A3C6B), width: 2),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _staticProfileInfoRow(IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.black, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, color: Color(0xFF23272F)),
          ),
        ),
      ],
    );
  }

  Widget buildBottomNavBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF7F2F0),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: 'Upload'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF1A3C6B),
      unselectedItemColor: const Color(0xFF8A8A8A),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AddSubmissionPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
            break;
        }
      },
    );
  }
}

class ProfileCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100); // Start from the bottom left
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100); // Curve up to the top right
    path.lineTo(size.width, 0); // Line to the top right
    path.lineTo(0, 0); // Line to the bottom left
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
