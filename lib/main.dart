import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/BuyerDashboard.dart';
import 'screens/SellerDashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotton Bales App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

/// Splash Screen to check user authentication & role
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  Future<void> checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? token = prefs.getString('token');
    String? role = prefs.getString('role'); // 'buyer' or 'seller'
    bool? isFirstTime = prefs.getBool('isFirstTime'); // To track first-time users

    await Future.delayed(Duration(seconds: 2)); // Simulating loading time

    if (token != null && role != null) {
      if (role == 'buyer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BuyerDashboard()),
        );
      } else if (role == 'seller') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SellerDashboard(sellerEmail: email!)),
        );
      }
    } else {
      // If the user is opening the app for the first time, go to Sign-Up
      if (isFirstTime == null || isFirstTime == true) {
        prefs.setBool('isFirstTime', false); // Mark as not first time
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      } else {
        // If the user is not a first-time user but not logged in, show Sign-In
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
