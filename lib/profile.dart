import 'package:flutter/material.dart';
import 'main_activity_user.dart';
import 'favorites.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF084DA6),
        toolbarHeight: 120,
        centerTitle: true,
        title: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/perfiluser.png'), // Ruta de tu imagen de perfil
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Campos de texto
            TextField(
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your first name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Gender',
                hintText: 'Enter your gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Birthdate',
                hintText: 'Enter your birthdate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Botón para ir a la pantalla principal
              IconButton(
                icon: Image.asset('assets/images/iconexplore2.png'), // Ruta de tu icono
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainActivity()),
                  );
                },
              ),
              // Botón para ir a la pantalla de favoritos
              IconButton(
                icon: Image.asset('assets/images/iconsaved.png'), // Ruta de tu icono
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
              ),
              // Botón de perfil
              IconButton(
                icon: Image.asset('assets/images/iconprofile.png'), // Ruta de tu icono
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
