import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'network/api_client.dart';
import 'packages_viewer.dart';
import 'user_type_starting_selector.dart'; // Pantalla inicial
import 'search.dart'; // Importa la pantalla de búsqueda
import 'results.dart'; // Importa la pantalla de resultados
import 'user_profile_view.dart'; // Importa la pantalla de perfil de usuario
import 'booking_communication.dart'; // Importa la pantalla de comunicación de reservas
import 'hotels_editor.dart'; // Importa la pantalla de edición de hoteles
import 'flights_editor.dart'; // Importa la pantalla de edición de vuelos
import 'restaurants_editor.dart'; // Importa la pantalla de edición de restaurantes
import 'attractions_editor.dart'; // Importa la pantalla de edición de atracciones
import 'packages_editor.dart'; // Importa la pantalla de edición de paquetes
import 'admin_panel.dart'; // Importa la pantalla de panel de administrador
import 'manage_packages_activity.dart'; // Importa la pantalla de administración de paquetes
import 'view_sales.dart'; // Importa la pantalla de visualización de ventas
import 'manage_package.dart'; // Importa la pantalla de administración de paquetes
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

  final apiClient = ApiClient(); // Instancia de ApiClient
  runApp(MyApp(apiClient: apiClient));
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient;

  MyApp({super.key, ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define las rutas de la aplicación
      initialRoute: '/',
      routes: {
        '/': (context) => UserTypeStartingSelector(),
        '/search': (context) => Search(apiClient: apiClient),
        '/results': (context) => Results(apiClient: apiClient),
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
        '/createTravelPackage': (context) => CreatePackage(apiClient: apiClient),
        '/continentsEditor': (context) => ContinentsEditor(),
        '/packageDetails': (context) => PackageViewer(apiClient: apiClient),
      },
    );
  }
}

// Inicializar y configurar Firebase Messaging
void initializeFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Solicitar permisos de notificación
  NotificationSettings settings = await messaging.requestPermission();
  print('Permisos de notificación: ${settings.authorizationStatus}');

  // Obtener el token de FCM para el dispositivo
  String? token = await messaging.getToken();
  print("Token de FCM: $token");

  // Manejar mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Mensaje recibido en primer plano: ${message.messageId}');
    if (message.notification != null) {
      print('Notificación: ${message.notification?.title} - ${message.notification?.body}');
    }
  });
}
