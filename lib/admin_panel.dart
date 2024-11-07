import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Admin Panel',
              style: TextStyle(
                color: Color(0xFF034BAB),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Divider below the AppBar
          Divider(
            color: Colors.grey,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(height: 20),
          // Row of options (Manage Packages and View Sales)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/managePackages');
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/manage_packages.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Manage Packages',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: 80,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewSales');
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/view_sales.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'View Sales',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
