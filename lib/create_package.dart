import 'package:flutter/material.dart';
import 'package:wanderlog_apli/network/continent_service.dart';
import 'package:wanderlog_apli/network/hotel_service.dart';
import 'package:wanderlog_apli/network/attraction_service.dart';
import 'package:wanderlog_apli/network/restaurant_service.dart';
import 'package:wanderlog_apli/network/flight_service.dart';
import 'package:wanderlog_apli/models/continent.dart';
import 'package:wanderlog_apli/models/hotels.dart';
import 'package:wanderlog_apli/models/attraction.dart';
import 'package:wanderlog_apli/models/restaurant.dart';
import 'package:wanderlog_apli/models/flight.dart';
import 'package:wanderlog_apli/network/travel_package_service.dart';

class CreatePackage extends StatefulWidget {
  const CreatePackage({super.key});

  @override
  _CreatePackageState createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  final ContinentService _continentService = ContinentService();
  final HotelService _hotelService = HotelService();
  final AttractionService _attractionService = AttractionService();
  final RestaurantService _restaurantService = RestaurantService();
  final FlightService _flightService = FlightService();

  String _destination = "";

  List<Continent> _continents = [];
  List<Hotel> _hotels = [];
  List<Attraction> _attractions = [];
  List<Restaurant> _restaurants = [];
  List<Flight> _flights = [];

  Continent? _selectedContinent;
  Hotel? _selectedHotel;
  Attraction? _selectedAttraction;
  Restaurant? _selectedRestaurant;
  Flight? _selectedFlight;

  bool _completed = false;
  bool _disabled = false;

  @override
  void initState() {
    super.initState();
    _loadContinents();
  }

  Future<void> _loadContinents() async {
    try {
      final continents = await _continentService.getAllContinents();
      setState(() {
        _continents = continents;
      });
    } catch (e) {
      print("Error loading continents: $e");
    }
  }

  Future<void> _loadDataByContinent(int continentId) async {
    try {
      final hotels = await _hotelService.getAllHotelsByContinentId(continentId);
      final attractions = await _attractionService.getAllAttractionsByContinentId(continentId);
      final restaurants = await _restaurantService.getAllRestaurantsByContinentId(continentId);
      final flights = await _flightService.getAllFlightsByContinentId(continentId);

      setState(() {
        _hotels = hotels;
        _attractions = attractions;
        _restaurants = restaurants;
        _flights = flights;

        _selectedHotel = null;
        _selectedAttraction = null;
        _selectedRestaurant = null;
        _selectedFlight = null;

        _completed = false;
      });
    } catch (e) {
      print("Error loading data by continent: $e");
    }
  }

  void _validateIfAllAreSelected() {
    setState(() {
      _completed = _selectedHotel != null &&
        _selectedAttraction != null &&
        _selectedRestaurant != null &&
        _selectedFlight != null &&
        _destination != "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(title: Text('Create Package')),
      body: Center (
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _destination = value;
                    _validateIfAllAreSelected();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter the name of the Package',
                  hintStyle: TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),

                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<Continent>(
                hint: const Text(
                  "Select Continent",
                  style: TextStyle(color: Colors.white60),
                ),
                value: _selectedContinent,
                items: _continents.map((continent) {
                  return DropdownMenuItem<Continent>(
                    value: continent,
                    child: Text(
                      continent.continentName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (continent) {
                  setState(() {
                    _selectedContinent = continent;
                    _validateIfAllAreSelected();
                  });
                  if (continent != null) {
                    _loadDataByContinent(continent.continentID);
                  }
                },
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 20),
              DropdownButton<Hotel>(
                hint: const Text(
                  "Select Hotel",
                  style: TextStyle(color: Colors.white60),
                ),
                value: _selectedHotel,
                items: _hotels.map((hotel) {
                  return DropdownMenuItem<Hotel>(
                    value: hotel,
                    child: Text(
                      hotel.hotelName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (hotel) {
                  setState(() {
                    _selectedHotel = hotel;
                    _validateIfAllAreSelected();
                  });
                },
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 10),
              DropdownButton<Attraction>(
                hint: const Text(
                  "Select Attraction",
                  style: TextStyle(color: Colors.white60),
                ),
                value: _selectedAttraction,
                items: _attractions.map((attraction) {
                  return DropdownMenuItem<Attraction>(
                    value: attraction,
                    child: Text(
                      attraction.attractionName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (attraction) {
                  setState(() {
                    _selectedAttraction = attraction;
                    _validateIfAllAreSelected();
                  });
                },
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 10),
              DropdownButton<Restaurant>(
                hint: const Text(
                  "Select Restaurant",
                  style: TextStyle(color: Colors.white60),
                ),
                value: _selectedRestaurant,
                items: _restaurants.map((restaurant) {
                  return DropdownMenuItem<Restaurant>(
                    value: restaurant,
                    child: Text(
                      restaurant.restaurantName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (restaurant) {
                  setState(() {
                    _selectedRestaurant = restaurant;
                    _validateIfAllAreSelected();
                  });
                },
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 10),
              DropdownButton<Flight>(
                hint: const Text(
                  "Select Flight",
                  style: TextStyle(color: Colors.white60),
                ),
                value: _selectedFlight,
                items: _flights.map((flight) {
                  return DropdownMenuItem<Flight>(
                    value: flight,
                    child: Text(
                      flight.airline,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (flight) {
                  setState(() {
                    _selectedFlight = flight;
                    _validateIfAllAreSelected();
                  });
                },
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 20),
              _completed?ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4C8E6),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Create Travel Package', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  try {
                    setState(() {
                      _disabled = true;
                    });
                    await TravelPackageService()
                        .createTravelPackage(
                        destination: _destination,
                        hotelId: _selectedHotel!.hotelId,
                        restaurantId: _selectedRestaurant!.restaurantId,
                        flightId: _selectedFlight!.flightId,
                        attractionId: _selectedAttraction!.attractionId,
                        pricePerStudent:
                        _selectedHotel!.pricePerNight +
                            _selectedFlight!.price * 2 +
                            _selectedAttraction!.ticketPrice,
                        agencyId: 1,
                        continent: _selectedContinent!.continentName
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Package successfully created!")),
                    );
                    Navigator.of(context).pop();
                  } catch (error){
                    setState(() { _disabled = false; });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to create a package")),
                    );
                  }
                },
              ):const SizedBox(height: 0)
            ],
          ),
        ),
      )
    );
  }
}
