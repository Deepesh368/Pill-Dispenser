import 'package:flutter/material.dart';
import 'package:pill_dispenser/pages/edit_sheet.dart';
import 'provider/google_sheets.dart';
import 'provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/edit_schedule.dart';
import 'pages/loggedin.dart';
import 'pages/home.dart';
import 'pages/home_page.dart';
import 'pages/launch.dart';
import 'pages/loading.dart';
import 'pages/signup.dart';
import 'pages/setup_schedule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleSheetsProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        EditSchedule.routeName: (context) => const EditSchedule(),
        SetUpSchedule.routeName: (context) => const SetUpSchedule(),
        LoggedIn.routeName: (context) => const LoggedIn(),
        '/launch': (context) => const Launch(),
        '/': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/signup': (context) => const SignUp(),
        '/home_page': (context) => const HomePage(),
        '/edit_sheet': (context) => const EditSheet(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
