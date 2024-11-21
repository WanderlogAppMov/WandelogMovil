import 'package:flutter/material.dart';

class ViewSales extends StatelessWidget {
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
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 2,
                  width: 20,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/view_sales_selected.png',
                      width: 60,
                      height: 60,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Image.asset(
                'assets/images/graficos_wanderlog.png', // Gráfico de ventas
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
