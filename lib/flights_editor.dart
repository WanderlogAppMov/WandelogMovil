import 'package:flutter/material.dart';
import 'package:wanderlog_movil/models/flight.dart';
import 'package:wanderlog_movil/network/continent_service.dart';
import 'package:wanderlog_movil/network/flight_service.dart';


import 'models/continent.dart';

class FlightsEditor extends StatefulWidget {
  const FlightsEditor({super.key});

  @override
  _FlightsEditorScreenState createState() => _FlightsEditorScreenState();
}

class _FlightsEditorScreenState extends State<FlightsEditor> {
  final FlightService _flightService = FlightService();
  final ContinentService _continentService = ContinentService();
  late Future<List<Flight>> _flightsFuture;
  List<Continent> _continents = List.empty();

  @override
  void initState() {
    super.initState();
    _updateFlyList();
    _initContinents();
  }

  Future<void> _initContinents() async {
    _continents = await _continentService.getAllContinents();
  }

  void _updateFlyList(){
    setState(() {
      _flightsFuture = _flightService.getAllFlights();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF034BAC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF034BAC)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 10),
            const Text(
              'Flights',
              style: TextStyle(
                color: Color(0xFF034BAC),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF034BAC)),
              onPressed: () => _showFlightDialog(),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Flight>>(
        future: _flightsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load flights: ${snapshot.error}')); // Muestra el error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No flights available'));
          } else {
            final flights = snapshot.data!;
            return _buildFlightList(flights);
          }
        },
      ),
    );
  }


  Widget _buildFlightList(List<Flight> flights) {
    // Agrupar los vuelos por continente
    final Map<String, List<Flight>> flightsByContinent = {};
    for (var flight in flights) {
      final continent = flight.continent.continentName; // Asume que `continentName` es parte de `Flight`
      flightsByContinent.putIfAbsent(continent, () => []).add(flight);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: flightsByContinent.entries.map((entry) {
        final continent = entry.key;
        final continentFlights = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              continent,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: continentFlights.map((flight) {
                  return Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              flight.imageUrl ?? 'https://via.placeholder.com/120',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              flight.airline,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${flight.departureCountry} to ${flight.arrivalCountry}',
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Price: \$${flight.price}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    _showFlightDialog(flight: flight); // Editar el vuelo
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _flightService.deleteFlight(flight);
                                    _updateFlyList();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  // Mostrar el cuadro de diálogo para agregar un nuevo vuelo
  void _showFlightDialog({Flight? flight}) {
    showDialog(context: context, builder: (context) {
        final TextEditingController _airlineController = TextEditingController(
            text: flight != null ? flight.airline : '');
        final TextEditingController _departureCountryController = TextEditingController(
            text: flight != null ? flight.departureCountry : '');
        final TextEditingController _arrivalCountryController = TextEditingController(
            text: flight != null ? flight.arrivalCountry : '');
        final TextEditingController _priceController = TextEditingController(
            text: flight != null ? flight.price.toString() : '');
        final TextEditingController _imageUrlController = TextEditingController(
            text: flight != null ? flight.imageUrl : '');

        Continent? selectedContinent;
        if (flight != null) {
          selectedContinent = flight.continent;
        }

        return AlertDialog(
          title: flight == null?Text("Add New Flight"):Text("Edit ${flight.airline}"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _airlineController,
                  decoration: const InputDecoration(labelText: "Airline"),
                ),
                TextField(
                  controller: _departureCountryController,
                  decoration: const InputDecoration(labelText: "Departure Country"),
                ),
                TextField(
                  controller: _arrivalCountryController,
                  decoration: const InputDecoration(labelText: "Arrival Country"),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
                DropdownMenu<Continent>(
                  hintText: "Select a Continent",
                  initialSelection: selectedContinent != null
                      ? _continents.firstWhere(
                        (Continent element) =>
                    element.continentName == selectedContinent?.continentName,
                    orElse: () => _continents.first,
                  )
                      : null,
                  onSelected: (Continent? newValue) {
                    setState(() {
                      selectedContinent = newValue;
                    });
                  },
                  dropdownMenuEntries: _continents
                      .map<DropdownMenuEntry<Continent>>((Continent continent) {
                    return DropdownMenuEntry<Continent>(
                      value: continent,
                      label: continent.continentName,
                    );
                  }).toList(),
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: "Image URL"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () async {
                if (selectedContinent == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a continent")),
                  );
                  return;
                }

                try {
                  if (flight != null) {
                    // Editar vuelo existente
                    await _flightService.updateFlight(
                      flightId: flight.flightId,
                      airline: _airlineController.text,
                      departureCountry: _departureCountryController.text,
                      arrivalCountry: _arrivalCountryController.text,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  } else {
                    // Crear nuevo vuelo
                    await _flightService.createFlight(
                      airline: _airlineController.text,
                      departureCountry: _departureCountryController.text,
                      arrivalCountry: _arrivalCountryController.text,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  }
                  _updateFlyList();

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error adding flight: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add flight: $e")),
                  );
                }
              },
            )
          ],
        );
      },
    );
  }
}