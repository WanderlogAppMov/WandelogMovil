import 'package:flutter/material.dart';

import 'network/api_client.dart';
import 'network/traveler_service.dart';

class RegisterTraveler extends StatefulWidget {
  @override
  _RegisterTravelerState createState() => _RegisterTravelerState();
}

class _RegisterTravelerState extends State<RegisterTraveler> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TravelerService _travelerService = TravelerService(apiClient: ApiClient());
  bool _isLoading = false;
  bool _acceptedTerms = false;

  void _register() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _birthdateController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must accept the terms and conditions')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _travelerService.registerTraveler(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        gender: _genderController.text,
        birthdate: _birthdateController.text,
        username: _emailController.text,
        password: _passwordController.text,
        roles: ['ROLE_TRAVELER'],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Traveler registered successfully')),
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

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
          content: SingleChildScrollView(
            child: Text(
                'Terms and Conditions\n\n'
                    '1. Introduction\n'
                    'Welcome to WanderLog. By registering as an agency, you agree to comply with and be bound by the following terms and conditions.\n\n'
                    '2. Use of Service\n'
                    'You agree to use the service only for lawful purposes and in a way that does not infringe the rights of others or restrict their use of the service.\n\n'
                    '3. Account Security\n'
                    'You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer.\n\n'
                    '4. Termination\n'
                    'We reserve the right to terminate your account at any time if you violate these terms and conditions.\n\n'
                    '5. Changes to Terms\n'
                    'We may update these terms and conditions from time to time. Your continued use of the service will be deemed acceptance of the updated terms.\n\n'
                    '6. Contact Us\n'
                    'If you have any questions about these terms and conditions, please contact us at support@wanderlog.com.'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
                  'Create an account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Create an account to experience everything\nWanderLog can offer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: 'Birthdate',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _birthdateController.text =
                        "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptedTerms = value ?? false;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: _showTermsAndConditions,
                      child: Text(
                        'I accept the terms and conditions',
                        style: TextStyle(
                          color: Color(0xFF034BAC),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
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
                    'Create',
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
    home: RegisterTraveler(),
  ));
}