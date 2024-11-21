import 'package:flutter/material.dart';
import 'models/TravelPackage.dart';
import 'models/attraction.dart';
import 'models/flight.dart';
import 'models/hotels.dart';
import 'models/restaurant.dart';
import 'network/api_client.dart';
import 'network/travel_package_service.dart';
import 'network/hotel_service.dart';
import 'network/attraction_service.dart';
import 'network/restaurant_service.dart';
import 'network/flight_service.dart';
import 'edit_package_dialog.dart';

class PackageViewer extends StatefulWidget {
  final ApiClient apiClient;

  const PackageViewer({super.key, required this.apiClient});

  @override
  _PackageViewerState createState() => _PackageViewerState();
}

class _PackageViewerState extends State<PackageViewer> {
  late final TravelPackageService _travelPackageService;
  late final HotelService _hotelService;
  late final AttractionService _attractionService;
  late final RestaurantService _restaurantService;
  late final FlightService _flightService;

  List<TravelPackage> _packages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _travelPackageService = TravelPackageService(apiClient: widget.apiClient);
    _hotelService = HotelService();
    _attractionService = AttractionService();
    _restaurantService = RestaurantService();
    _flightService = FlightService();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    try {
      final packages = await _travelPackageService.getAllTravelPackages();
      setState(() {
        _packages = packages;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading packages: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deletePackage(int packageId) async {
    try {
      await _travelPackageService.deleteTravelPackage(packageId);
      setState(() {
        _packages.removeWhere((package) => package.travelPackageId == packageId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Package successfully deleted!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete package")),
      );
    }
  }

  // Método para abrir el popup de edición
  void _editPackage(TravelPackage package) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPackageDialog(package: package, apiClient: widget.apiClient);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(title: const Text('View Travel Packages')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _packages.isEmpty
          ? const Center(
        child: Text(
          "No travel packages available.",
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: _packages.length,
        itemBuilder: (context, index) {
          final package = _packages[index];
          return Card(
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      package.destination,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF034BAC),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.network(
                    package.hotel!.imageUrl,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(package.hotel!.hotelName),
                  subtitle: Text("Hotel"),
                ),
                ListTile(
                  leading: Image.network(
                    package.restaurant!.imageUrl,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(package.restaurant!.restaurantName),
                  subtitle: Text("Restaurant"),
                ),
                ListTile(
                  leading: Image.network(
                    package.attraction!.imageUrl ?? 'https://asset.japan.travel/image/upload/v1646014276/tokyo/H_00658_001.jpg',
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(package.attraction!.attractionName),
                  subtitle: Text("Attraction"),
                ),
                ListTile(
                  leading: Image.network(
                    package.flight!.imageUrl ?? 'https://asset.japan.travel/image/upload/v1646014276/tokyo/H_00658_001.jpg',
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(package.flight!.airline),
                  subtitle: Text("Flight"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _deletePackage(package.travelPackageId),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}