import 'package:flutter/material.dart';

class PackagesEditor extends StatelessWidget {
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
            buildPackageItem(context, 'assets/images/imagenes_wanderlog.png'),
            buildPackageItem(context, 'assets/images/imagenes_wanderlog.png'),
            buildPackageItem(context, 'assets/images/imagenes_wanderlog.png'),
            buildPackageItem(context, 'assets/images/imagenes_wanderlog.png'),
          ],
        ),
      ),
    );
  }

  Widget buildPackageItem(BuildContext context, String imagePath) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Image.asset(
            imagePath,
            width: 200,
            height: 150,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Icon(Icons.star, color: Colors.yellow, size: 30);
          })
            ..add(Icon(Icons.star_border, color: Colors.white, size: 30)),
        ),
        SizedBox(height: 10),
        IconButton(
          icon: Image.asset(
            'assets/images/edit_white.png', // Ruta de la imagen del ícono de edición
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          onPressed: () {
            // Redirige a la pantalla ManagePackages
            Navigator.pushNamed(context, '/managePackage');
          },
        ),
        Divider(color: Colors.grey, thickness: 2, indent: 20, endIndent: 20),
      ],
    );
  }
}
