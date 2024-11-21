import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wanderlog_movil/utils/dbservice.dart';
import 'models/TravelPackage.dart';
import 'models/list_reviews.dart';
import 'network/api_client.dart';
import 'network/travel_package_service.dart';
import 'reviews_screen.dart';

class PackageDetails extends StatefulWidget {
  final TravelPackage travelPackage;

  PackageDetails({required this.travelPackage});

  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  late TravelPackage travelPackage;
  late Dbservice dbservice;

  @override
  void initState() {
    super.initState();
    travelPackage = widget.travelPackage;
    dbservice = Dbservice();
  }

  Future<void> _toggleReservation() async {
    final service = TravelPackageService(apiClient: ApiClient());

    try {
      final newReservedState = travelPackage.reserved == 0 ? 1 : 0;
      final updateData = {
        "destination": travelPackage.destination,
        "hotelId": travelPackage.hotel?.hotelId ?? 0,
        "restaurantId": travelPackage.restaurant?.restaurantId ?? 0,
        "flightId": travelPackage.flight?.flightId ?? 0,
        "attractionId": travelPackage.attraction?.attractionId ?? 0,
        "pricePerStudent": travelPackage.pricePerStudent,
        "continent": travelPackage.continent,
        "reserved": newReservedState,
      };
      final body = jsonEncode(updateData);

      await service.updateTravelPackageFull(
        travelPackageId: travelPackage.travelPackageId,
        body: body,
      );

      setState(() {
        travelPackage = TravelPackage(
          travelPackageId: travelPackage.travelPackageId,
          destination: travelPackage.destination,
          hotel: travelPackage.hotel,
          restaurant: travelPackage.restaurant,
          flight: travelPackage.flight,
          attraction: travelPackage.attraction,
          pricePerStudent: travelPackage.pricePerStudent,
          continent: travelPackage.continent,
          reserved: newReservedState,
        );
      });

      print('Package updated successfully.');
    } catch (e) {
      print('Error updating reservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update reservation.')),
      );
    }
  }

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
            Text(
              travelPackage.destination,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${travelPackage.pricePerStudent.toStringAsFixed(2)} per traveler',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleReservation,
              style: ElevatedButton.styleFrom(
                backgroundColor: travelPackage.reserved == 0 ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(travelPackage.reserved == 0 ? 'Disponible' : 'Reservado'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await dbservice.openDb();
                List<ListReviews> reviews = await dbservice.getReviewsByTravelPackageId(travelPackage.travelPackageId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsScreen(
                      travelPackageId: travelPackage.travelPackageId,
                      reviews: reviews,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('View Reviews'),
            ),
            SizedBox(height: 16),
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