import 'package:flutter/material.dart';
import 'models/TravelPackage.dart';

class PackageDetails extends StatelessWidget {
  final TravelPackage travelPackage;

  PackageDetails({required this.travelPackage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF084DA6),
        title: Text(travelPackage.destination),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del paquete
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/detailimage1.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 16),
            // Título del paquete
            Text(
              travelPackage.destination,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Precio del paquete
            Text(
              '\$${travelPackage.pricePerStudent.toStringAsFixed(2)} per traveler',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            // Grid con botones para detalles adicionales
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildInfoItem(
                    context,
                    'assets/images/hotelicon.png',
                    travelPackage.hotel?.hotelName ?? 'No hotel',
                    travelPackage.hotel != null
                        ? "Country: ${travelPackage.hotel!.country}\nCity: ${travelPackage.hotel!.city}\nStars: ${travelPackage.hotel!.stars}\nPrice per Night: \$${travelPackage.hotel!.pricePerNight}"
                        : "No details available",
                  ),
                  _buildInfoItem(
                    context,
                    'assets/images/flighticon.png',
                    travelPackage.flight?.airline ?? 'No flight',
                    travelPackage.flight != null
                        ? "From: ${travelPackage.flight!.departureCountry}\nTo: ${travelPackage.flight!.arrivalCountry}\nPrice: \$${travelPackage.flight!.price}"
                        : "No details available",
                  ),
                  _buildInfoItem(
                    context,
                    'assets/images/restauranticon.png',
                    travelPackage.restaurant?.restaurantName ?? 'No restaurant',
                    travelPackage.restaurant != null
                        ? "Country: ${travelPackage.restaurant!.country}\nCity: ${travelPackage.restaurant!.city}\nCuisine: ${travelPackage.restaurant!.cuisineType}\nPrice Range: ${travelPackage.restaurant!.priceRange}"
                        : "No details available",
                  ),
                  _buildInfoItem(
                    context,
                    'assets/images/attractionicon.png',
                    travelPackage.attraction?.attractionName ?? 'No attraction',
                    travelPackage.attraction != null
                        ? "Country: ${travelPackage.attraction!.country}\nCity: ${travelPackage.attraction!.city}\nTicket Price: \$${travelPackage.attraction!.ticketPrice}"
                        : "No details available",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String iconPath, String title, String details) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icono sin bordes redondeados
                    Image.asset(
                      iconPath,
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Detalles del item en estilo de lista
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        details,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Botón de cierre con texto en blanco
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF084DA6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Close"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 60,
            height: 60,
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
