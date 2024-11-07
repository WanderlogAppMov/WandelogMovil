import 'package:flutter/material.dart';
import 'package:wanderlog_movil/profile.dart';
import 'package:wanderlog_movil/search.dart';
import 'favorites.dart';


class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF084DA6),
        toolbarHeight: 60.0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/wanderlogotol.png', // Ruta de tu logo
          height: 50,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Botón y texto de paquetes
              Column(
                children: [
                  IconButton(
                    iconSize: 80, // Aumenta el tamaño para resaltar
                    icon: Image.asset('assets/images/tour_package_icon_vector_1_removebg_preview_1.png'), // Ruta de tu icono
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                      );
                    },
                  ),
                  const Text(
                    'Packages',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Título de Popular Destination
              const Text(
                'Popular destination',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              // Imagen principal
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Esquinas redondeadas para la imagen
                child: Image.asset(
                  'assets/images/cuscoofi.png', // Ruta de tu imagen
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Footer button 1
              IconButton(
                icon: Image.asset('assets/images/iconexplore2.png'), // Ruta de tu icono
                onPressed: () {},
              ),
              // Footer button 2 (Favorites)
              IconButton(
                icon: Image.asset('assets/images/iconsaved.png'), // Ruta de tu icono
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
              ),
              // Footer button 3 (Profile)
              IconButton(
                icon: Image.asset('assets/images/iconprofile.png'), // Ruta de tu icono
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
