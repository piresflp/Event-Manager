import 'package:Even7/pages/EventDetails/EventDetailsPage.dart';
import 'package:Even7/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'pages/RootApp.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var id = preferences.getString('id');
  runApp(id == null
      ? const MyApp(initialRoute: '/login')
      : const MyApp(initialRoute: '/'));
}

class MyApp extends StatelessWidget {
  final initialRoute;
  const MyApp({Key? key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Even7',
      initialRoute: initialRoute,
      routes: {
        '/': (context) => EventDetailsPage(),
        '/login': (context) => LoginPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
