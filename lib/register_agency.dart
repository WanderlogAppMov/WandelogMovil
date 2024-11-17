import 'package:flutter/material.dart';
import 'network/api_client.dart';
import 'network/agency_service.dart';

class RegisterAgency extends StatefulWidget {
  @override
  _RegisterAgencyState createState() => _RegisterAgencyState();
}

class _RegisterAgencyState extends State<RegisterAgency> {
  final TextEditingController _organizationNameController = TextEditingController();
  final TextEditingController _repreFirstNameController = TextEditingController();
  final TextEditingController _repreLastNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AgencyService _agencyService = AgencyService(apiClient: ApiClient());
  bool _isLoading = false;

  void _register() async {
    if (_organizationNameController.text.isEmpty ||
        _repreFirstNameController.text.isEmpty ||
        _repreLastNameController.text.isEmpty ||
        _contactEmailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _agencyService.registerAgency(
        organizationName: _organizationNameController.text,
        repreFirstName: _repreFirstNameController.text,
        repreLastName: _repreLastNameController.text,
        username: _contactEmailController.text,
        password: _passwordController.text,
        roles: ['ROLE_AGENCY'],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Agency registered successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
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
      backgroundColor: Color(0xFFE0E8F9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/wanderlogotol.png',
                  height: 100,
                ),
                SizedBox(height: 10),
                Text(
                  'Register your agency',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Create an account to manage your agency on WanderLog.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _organizationNameController,
                  decoration: InputDecoration(
                    labelText: 'Organization Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _repreFirstNameController,
                  decoration: InputDecoration(
                    labelText: 'Representative First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _repreLastNameController,
                  decoration: InputDecoration(
                    labelText: 'Representative Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _contactEmailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF034BAC),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterAgency(),
  ));
}