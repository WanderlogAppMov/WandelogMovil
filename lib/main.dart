import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'user_type_starting_selector.dart';
import 'search.dart';
import 'results.dart';
import 'user_profile_view.dart';
import 'booking_communication.dart';
import 'hotels_editor.dart';
import 'flights_editor.dart';
import 'restaurants_editor.dart';
import 'attractions_editor.dart';
import 'packages_editor.dart';
import 'admin_panel.dart';
import 'manage_packages_activity.dart';
import 'view_sales.dart';
import 'manage_package.dart';
import 'create_package.dart';
import 'manage_continents.dart';

// Manejador para mensajes en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Mensaje recibido en segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Suscribirse al topic "all" para recibir notificaciones masivas
  FirebaseMessaging.instance.subscribeToTopic("all");

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _notificationMessage = "No hay mensajes"; // Variable para mostrar el mensaje recibido

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  // Método para configurar Firebase Messaging y obtener el token FCM
  void _initializeFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Solicitar permisos de notificación
    NotificationSettings settings = await messaging.requestPermission();
    print('Permisos de notificación: ${settings.authorizationStatus}');

    // Obtiene el token de FCM para el dispositivo
    String? token = await messaging.getToken();
    print("Token de FCM: $token");

    // Maneja mensajes en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensaje recibido en primer plano: ${message.messageId}');

      // Muestra un Snackbar con el contenido de la notificación
      if (message.notification != null) {
        _showSnackbar(message.notification?.title ?? '', message.notification?.body ?? '');
      }
    });
  }

  // Función para mostrar el Snackbar
  void _showSnackbar(String title, String body) {
    final snackBar = SnackBar(
      content: Text('$title: $body'),
      duration: Duration(seconds: 3), // Duración del Snackbar
    );

    // Usa ScaffoldMessenger directamente desde el contexto
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Notificaciones Firebase"),
        ),
        body: Center(
          child: Text(
            _notificationMessage, // Muestra el mensaje en la pantalla
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/search': (context) => Search(),
        '/results': (context) => Results(),
        '/userProfileView': (context) => UserProfileView(),
        '/bookingCommunication': (context) => BookingCommunication(),
        '/hotelsEditor': (context) => HotelsEditor(),
        '/flightsEditor': (context) => FlightsEditor(),
        '/restaurantsEditor': (context) => RestaurantsEditor(),
        '/attractionsEditor': (context) => AttractionsEditor(),
        '/packagesEditor': (context) => PackagesEditor(),
        '/adminPanel': (context) => AdminPanel(),
        '/managePackages': (context) => ManagePackages(),
        '/viewSales': (context) => ViewSales(),
        '/managePackage': (context) => ManagePackage(),
        '/createTravelPackage': (context) => CreatePackage(),
        '/continentsEditor': (context) => ContinentsEditor(),
      },
    );
  }
}
