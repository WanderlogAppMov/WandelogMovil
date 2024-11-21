import 'package:flutter/material.dart';
import 'models/TravelPackage.dart';
import 'models/attraction.dart';
import 'models/flight.dart';
import 'models/hotels.dart';
import 'models/restaurant.dart';
import 'network/api_client.dart';
import 'network/attraction_service.dart';
import 'network/flight_service.dart';
import 'network/hotel_service.dart';
import 'network/restaurant_service.dart';
import 'network/travel_package_service.dart';

class EditPackageDialog extends StatefulWidget {
  final TravelPackage package;
  final ApiClient apiClient;

  const EditPackageDialog({super.key, required this.package, required this.apiClient});

  @override
  _EditPackageDialogState createState() => _EditPackageDialogState();
}

class _EditPackageDialogState extends State<EditPackageDialog> {
  late TextEditingController _destinationController;
  late Hotel _selectedHotel = widget.package.hotel!;
  late Attraction _selectedAttraction = widget.package.attraction!;
  late Restaurant _selectedRestaurant = widget.package.restaurant!;
  late Flight _selectedFlight = widget.package.flight!;
  late final TravelPackageService _travelPackageService;

  List<Hotel> _hotels = [];
  List<Attraction> _attractions = [];
  List<Restaurant> _restaurants = [];
  List<Flight> _flights = [];

  @override
  void initState() {
    super.initState();
    _travelPackageService = TravelPackageService(apiClient: widget.apiClient);
    _destinationController = TextEditingController(text: widget.package.destination);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Carga los datos de los servicios sin envolverlos en setState
      final hotels = await HotelService().getAllHotels();
      final attractions = await AttractionService().getAllAttraction();
      final restaurants = await RestaurantService().getAllRestaurants();
      final flights = await FlightService().getAllFlights();

      // Actualiza el estado con los resultados obtenidos
      setState(() {
        _hotels = hotels;
        _attractions = attractions;
        _restaurants = restaurants;
        _flights = flights;
      });
    } catch (e) {
      // Manejo de errores si algo sale mal durante la carga de datos
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Travel Package'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(labelText: 'Package Name'),
            ),
            const SizedBox(height: 10),
            DropdownButton<Hotel>(
              value: _selectedHotel,
              hint: const Text('Select Hotel'),
              items: _hotels.map<DropdownMenuItem<Hotel>>((Hotel hotel) {
                return DropdownMenuItem<Hotel>(
                  value: hotel,
                  child: Text(hotel.hotelName),
                );
              }).toList(),
              onChanged: (hotel) {
                setState(() {
                  _selectedHotel = hotel!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<Attraction>(
              value: _selectedAttraction,
              hint: const Text('Select Attraction'),
              items: _attractions.map((attraction) {
                return DropdownMenuItem<Attraction>(
                  value: attraction,
                  child: Text(attraction.attractionName),
                );
              }).toList(),
              onChanged: (attraction) {
                setState(() {
                  _selectedAttraction = attraction!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<Restaurant>(
              value: _selectedRestaurant,
              hint: const Text('Select Restaurant'),
              items: _restaurants.map((restaurant) {
                return DropdownMenuItem<Restaurant>(
                  value: restaurant,
                  child: Text(restaurant.restaurantName),
                );
              }).toList(),
              onChanged: (restaurant) {
                setState(() {
                  _selectedRestaurant = restaurant!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<Flight>(
              value: _selectedFlight,
              hint: const Text('Select Flight'),
              items: _flights.map((flight) {
                return DropdownMenuItem<Flight>(
                  value: flight,
                  child: Text(flight.airline),
                );
              }).toList(),
              onChanged: (flight) {
                setState(() {
                  _selectedFlight = flight!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Llamar al método de actualización en tu servicio.
            _travelPackageService.updateTravelPackage(
              id: widget.package.travelPackageId,
              destination: _destinationController.text,
              hotelId: _selectedHotel!.hotelId,
              attractionId: _selectedAttraction!.attractionId,
              restaurantId: _selectedRestaurant!.restaurantId,
              flightId: _selectedFlight!.flightId,
              continent: widget.package.continent,
              pricePerStudent: widget.package.pricePerStudent,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}