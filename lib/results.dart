import 'package:flutter/material.dart';
import 'PackageDetails.dart';
import 'models/TravelPackage.dart';
import 'favorite_manager.dart';
import 'network/travel_package_service.dart'; // Importa el servicio

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late String destination;
  double minPrice = 0; // Valores iniciales válidos
  double maxPrice = double.infinity;
  late String order;
  List<TravelPackage> travelPackages = [];
  final TravelPackageService _travelPackageService = TravelPackageService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    destination = args['destination'] ?? '';
    minPrice = args.containsKey('minPrice') ? double.tryParse(args['minPrice'].toString()) ?? 0 : 0;
    maxPrice = args.containsKey('maxPrice') ? double.tryParse(args['maxPrice'].toString()) ?? double.infinity : double.infinity;
    order = args['order'] ?? 'Ascending';
  }

  Future<List<TravelPackage>> _fetchTravelPackages() async {
    try {
      List<TravelPackage> packages = await _travelPackageService.getAllTravelPackages();
      print(packages); // Agrega esta línea para inspeccionar la respuesta
      return packages.where((package) {
        final matchesDestination = destination.isEmpty || package.destination.contains(destination);
        final matchesPrice = (package.pricePerStudent ?? 0) >= minPrice && (package.pricePerStudent ?? double.infinity) <= maxPrice;
        return matchesDestination && matchesPrice;
      }).toList();
    } catch (error) {
      print('Error fetching travel packages: $error');
      throw error; // Asegúrate de lanzar el error para que el FutureBuilder lo maneje
    }
  }



  void handleFavoriteClick(TravelPackage travelPackage) {
    setState(() {
      if (FavoriteManager.isFavorite(travelPackage)) {
        FavoriteManager.removePackage(travelPackage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${travelPackage.destination} removed from favorites')),
        );
      } else {
        FavoriteManager.addPackage(travelPackage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${travelPackage.destination} added to favorites')),
        );
      }
    });
  }

  void navigateToDetails(TravelPackage travelPackage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetails(travelPackage: travelPackage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF084DA6),
        title: Text("Results"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<TravelPackage>>(
        future: _fetchTravelPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load travel packages: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No travel packages available'));
          } else {
            final travelPackages = snapshot.data!;
            return ListView.builder(
              itemCount: travelPackages.length,
              itemBuilder: (context, index) {
                final package = travelPackages[index];
                final isFavorite = FavoriteManager.isFavorite(package);
                return ListTile(
                  title: Text(package.destination),
                  subtitle: Text('Price per student: \$${package.pricePerStudent}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null),
                        onPressed: () => handleFavoriteClick(package),
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () => navigateToDetails(package),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
