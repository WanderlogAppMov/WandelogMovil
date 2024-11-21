import 'package:flutter/material.dart';

class MainActivity2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Desactiva la flecha de regreso
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/images/user_blue.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/userProfileView');
              },
            ),
            Image.asset(
              'assets/images/wanderlog_logo.png',
              width: 100,
              height: 100,
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/blue_chat.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/bookingCommunication');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/telos.png'),
                  iconSize: 90,
                  onPressed: () {
                    Navigator.pushNamed(context, '/hotelsEditor');
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/images/vuelos.png'),
                  iconSize: 90,
                  onPressed: () {
                    Navigator.pushNamed(context, '/flightsEditor');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/restaurantes.png'),
                  iconSize: 90,
                  onPressed: () {
                    Navigator.pushNamed(context, '/restaurantsEditor');
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/images/atracciones.png'),
                  iconSize: 90,
                  onPressed: () {
                    Navigator.pushNamed(context, '/attractionsEditor');
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB4C8E6),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Post Travel Package', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pushNamed(context, '/packagesEditor');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB4C8E6),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Manage Bookings', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pushNamed(context, '/adminPanel');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB4C8E6),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Create Travel Package', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pushNamed(context, '/createTravelPackage');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB4C8E6),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Manage Continents List', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pushNamed(context, '/continentsEditor');
              },
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/bottom_main.png'), // Imagen debajo de los botones
          ],
        ),
      ),
    );
  }
}
