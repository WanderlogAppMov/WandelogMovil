import 'package:flutter/material.dart';

class ManagePackages extends StatelessWidget {
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
                Column(
                  children: [
                    Image.asset(
                      'assets/images/manage_packages.png',
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      "Manage Packages",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 2,
                  width: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewSales');
                      },
                      child: Image.asset(
                        'assets/images/view_sales.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text(
                      "View Sales",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
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
            buildPackageSection(
              context,
              packageImage: 'assets/images/imagenes_wanderlog.png',
              rating: 4,
              onEditPressed: () {
                Navigator.pushNamed(context, '/managePackage');
              },
            ),
            Divider(color: Colors.grey, thickness: 2, indent: 20, endIndent: 20),
            buildPackageSection(
              context,
              packageImage: 'assets/images/imagenes_wanderlog.png',
              rating: 4,
              onEditPressed: () {
                Navigator.pushNamed(context, '/managePackage');
              },
            ),
            Divider(color: Colors.grey, thickness: 2, indent: 20, endIndent: 20),
            buildPackageSection(
              context,
              packageImage: 'assets/images/imagenes_wanderlog.png',
              rating: 4,
              onEditPressed: () {
                Navigator.pushNamed(context, '/managePackage');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageSection(
      BuildContext context, {
        required String packageImage,
        required int rating,
        required VoidCallback onEditPressed,
      }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              packageImage,
              width: 200,
              height: 120,
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: onEditPressed,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: index < rating ? Colors.yellow : Colors.white,
              size: 30,
            );
          }),
        ),
      ],
    );
  }
}
