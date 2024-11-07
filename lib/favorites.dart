import 'package:flutter/material.dart';
import 'package:wanderlog_movil/PackageDetails.dart';
import 'package:wanderlog_movil/favorite_manager.dart';
import 'package:wanderlog_movil/profile.dart';

import 'main_activity_user.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritePackages = FavoriteManager.getFavoritePackages();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: Color(0xFF084DA6),
      ),
      body: favoritePackages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        itemCount: favoritePackages.length,
        itemBuilder: (context, index) {
          final travelPackage = favoritePackages[index];
          return ListTile(
            title: Text(travelPackage.destination),
            subtitle: Text("${travelPackage.continent}, ${travelPackage.agency.organizationName}"),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                FavoriteManager.removePackage(travelPackage);
                setState(() {}); // Refresca la pantalla después de eliminar un favorito
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetails(travelPackage: travelPackage),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset('assets/images/iconexplore2.png'), // Icono de exploración personalizado
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainActivity()),
                  );                },
              ),
              IconButton(
                icon: Image.asset('assets/images/iconsaved.png'), // Icono de favoritos personalizado
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('assets/images/iconprofile.png'), // Icono de perfil personalizado
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/emptysavedimage.png", width: 100, height: 100),
          SizedBox(height: 16),
          Text("No favorites yet", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Tap the heart icon on a package to save it here."),
        ],
      ),
    );
  }
}
