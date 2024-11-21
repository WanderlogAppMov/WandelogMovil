import 'package:flutter/material.dart';

class ManagePackage extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/managePackages');
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/manage_packages_selected.png',
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Manage Packages",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 2,
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewSales');
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/view_sales.png',
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "View Sales",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            buildEditableRow("Package Name", 'assets/images/white_setings.png'),
            buildEditableRow("Hotels", 'assets/images/white_setings.png', isTextField: true),
            buildEditableRow("Flights", 'assets/images/white_setings.png', isTextField: true),
            buildEditableRow("Restaurants", 'assets/images/white_setings.png', isTextField: true),
            buildEditableRow("Attractions", 'assets/images/white_setings.png', isTextField: true),
          ],
        ),
      ),
    );
  }

  Widget buildEditableRow(String label, String iconPath, {bool isTextField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
      child: Row(
        children: [
          isTextField
              ? Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: label,
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
          )
              : Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(width: 10),
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
