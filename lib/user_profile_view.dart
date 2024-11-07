import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF034BAC)), // Flecha de regreso
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset(
            'assets/images/wanderlog_logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 180, // Icono de usuario en color blanco
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Icon(Icons.star, color: Colors.yellow, size: 40);
              })
                ..add(Icon(Icons.star_border, color: Colors.white, size: 40)),
            ),
            SizedBox(height: 16),
            buildProfileField(
              hintText: 'Agency Name',
              icon: Icons.edit,
            ),
            SizedBox(height: 10),
            buildProfileField(
              hintText: 'Mail',
              icon: Icons.edit,
            ),
            SizedBox(height: 10),
            buildProfileField(
              hintText: 'Date Joined',
              icon: Icons.edit,
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/data_chart.png',
              width: 300,
              height: 150,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Color(0xFF034BAC)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField({required String hintText, required IconData icon}) {
    return Container(
      width: 300,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(width: 8),
          Icon(
            icon,
            color: Colors.white, // Ícono de lápiz en color blanco
            size: 30,
          ),
        ],
      ),
    );
  }
}
