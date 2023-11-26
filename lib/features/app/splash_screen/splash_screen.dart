import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;

  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (widget.child != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.child!),
            (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFDF0FF), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your logo
              Image.asset(
                'assets/images/logo1.png', // Adjust the path accordingly
                width: 200, // Adjust the size of the logo as needed
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20), // Adjust spacing as needed
              // Text(
              //   "Welcome to Flutter Firebase",
              //   style: TextStyle(
              //     color: Colors.purpleAccent,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }




  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: Center(
  //       child: Text(
  //         "Welcome to flutter firebase",
  //         style: TextStyle(
  //             color: Colors.purpleAccent,
  //             fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }


}
