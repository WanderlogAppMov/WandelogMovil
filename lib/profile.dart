import 'package:flutter/material.dart';
import 'main_activity_user.dart';
import 'favorites.dart';
import 'network/api_client.dart';
import 'network/traveler_service.dart';

class Profile extends StatefulWidget {
  final ApiClient apiClient;
  final String userId;

  Profile({required this.apiClient, required this.userId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  bool _isLoading = false;
  late TravelerService _travelerService;

  @override
  void initState() {
    super.initState();
    _travelerService = TravelerService(apiClient: widget.apiClient);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final profile = await _travelerService.getProfileById(widget.userId);
      _firstNameController.text = profile['firstName'];
      _lastNameController.text = profile['lastName'];
      _genderController.text = profile['gender'];
      _birthdateController.text = profile['birthdate'];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _travelerService.updateProfileById(widget.userId, {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'gender': _genderController.text,
        'birthdate': _birthdateController.text,
        'username': '',
        'password': '',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF084DA6),
        toolbarHeight: 120,
        centerTitle: true,
        title: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/perfiluser.png'),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your first name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                hintText: 'Enter your gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _birthdateController,
              decoration: InputDecoration(
                labelText: 'Birthdate',
                hintText: 'Enter your birthdate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF034BAC),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset('assets/images/iconexplore2.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainActivity(apiClient: widget.apiClient, userId: widget.userId)),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/iconsaved.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen(apiClient: widget.apiClient, userId: widget.userId)),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/iconprofile.png'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}