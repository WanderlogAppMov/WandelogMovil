import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wanderlog_movil/models/hotels.dart';
import 'package:wanderlog_movil/network/continent_service.dart';
import 'package:wanderlog_movil/network/hotel_service.dart';

import 'models/continent.dart';

class HotelsEditor extends StatefulWidget {
  @override
  _HotelsEditorScreenState createState() => _HotelsEditorScreenState();
}

class _HotelsEditorScreenState extends State<HotelsEditor> {
  final HotelService _hotelService = HotelService();
  late Future<List<Hotel>> _hotelsFuture;
  final ContinentService _continentService = ContinentService();
  Continent? selectedContinent;
  List<Continent> continents = List.empty();

  @override
  void initState() {
    super.initState();
    loadHotels();
    loadContinents();
  }

  void loadHotels(){
    setState(() {
      _hotelsFuture = _hotelService.getAllHotels();
    });
  }

  Future<void> loadContinents() async {
    setState(() async {
      continents = await _continentService.getAllContinents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF034BAC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF034BAC)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(width: 10),
            Text(
              'Hotels',
              style: TextStyle(
                color: Color(0xFF034BAC),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add, color: Color(0xFF034BAC)),
              onPressed: () => _showHotelDialog(),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Hotel>>(
        future: _hotelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load hotels'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hotels available'));
          } else {
            final hotels = snapshot.data!;
            return _buildHotelList(hotels);
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Lógica para agregar a un plan
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF034BAC),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Add to Plan'),
        ),
      ),
    );
  }

  Widget _buildHotelList(List<Hotel> hotels) {
    // Agrupar los hoteles por continente
    final Map<String, List<Hotel>> hotelsByContinent = {};
    for (var hotel in hotels) {
      final continent = hotel.continent.continentName; // Asegúrate de que `continentName` sea parte de `Hotel`
      hotelsByContinent.putIfAbsent(continent, () => []).add(hotel);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: hotelsByContinent.entries.map((entry) {
        final continent = entry.key;
        final continentHotels = entry.value;

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
                children: continentHotels.map((hotel) {
                  return Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 200, // Ancho para la tarjeta del hotel
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              hotel.imageUrl ?? 'https://via.placeholder.com/120',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hotel.hotelName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${hotel.city}, ${hotel.country}',
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Stars: ${hotel.stars}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '\$${hotel.pricePerNight} per night',
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
                                    _showHotelDialog(hotel: hotel);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _hotelService.deleteHotel(hotel);
                                    loadHotels();
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

  // Mostrar el cuadro de diálogo para agregar un nuevo hotel
  void _showHotelDialog({Hotel? hotel}) {
    final TextEditingController _hotelNameController =
    TextEditingController(text: hotel != null ? hotel.hotelName : '');
    final TextEditingController _cityController =
    TextEditingController(text: hotel != null ? hotel.city : '');
    final TextEditingController _countryController =
    TextEditingController(text: hotel != null ? hotel.country : '');
    final TextEditingController _imageUrlController =
    TextEditingController(text: hotel != null ? hotel.imageUrl : '');
    final TextEditingController _starsController =
    TextEditingController(text: hotel != null ? hotel.stars.toString() : '');
    final TextEditingController _pricePerNightController =
    TextEditingController(text: hotel != null ? hotel.pricePerNight.toString() : '');

    if (hotel != null) {
      setState(() {
        selectedContinent = hotel.continent;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: hotel != null
              ? Text("Edit ${hotel.hotelName}")
              : const Text("Add New Hotel"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _hotelNameController,
                  decoration: const InputDecoration(labelText: "Hotel Name"),
                ),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: "City"),
                ),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country"),
                ),
                TextField(
                  controller: _starsController,
                  decoration: const InputDecoration(labelText: "Stars (1-5)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _pricePerNightController,
                  decoration: const InputDecoration(labelText: "Price Per Night"),
                  keyboardType: TextInputType.number,
                ),
                DropdownMenu<Continent>(
                  hintText: "Select a Continent",
                  initialSelection: selectedContinent != null
                      ? continents.firstWhere(
                          (Continent element) => element.continentName == selectedContinent?.continentName)
                      : selectedContinent,
                  onSelected: (Continent? newValue) {
                    setState(() {
                      selectedContinent = newValue;
                    });
                  },
                  dropdownMenuEntries: continents.map<DropdownMenuEntry<Continent>>((Continent continent) {
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
                  if (hotel != null) {
                    await _hotelService.updateHotel(
                      hotelId: hotel.hotelId,
                      hotelName: _hotelNameController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                      stars: int.tryParse(_starsController.text) ?? 0,
                      pricePerNight: double.tryParse(_pricePerNightController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  } else {
                    await _hotelService.createHotel(
                      hotelName: _hotelNameController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                      stars: int.tryParse(_starsController.text) ?? 0,
                      pricePerNight: double.tryParse(_pricePerNightController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  }

                  // Actualizar la lista de hoteles
                  setState(() {
                    _hotelsFuture = _hotelService.getAllHotels();
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error adding hotel: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add hotel: $e")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}