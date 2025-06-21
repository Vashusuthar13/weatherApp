import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/view/dashboard_screen/dashboard_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                        color: Colors.white10,
                        spreadRadius: 10,
                        blurRadius: 60.0,
                      ),]
                  ),
                  child: Image.asset(
                    'assets/images/thunder.png',
                    fit: BoxFit.cover,
                  ),
                ),



                 Column(
                   children: [
                     Text(
                       textAlign: TextAlign.center,
                      'Daily\nWeather',
                     style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600,color: Colors.white), ),


                const SizedBox(height: 30),


                Text(
                  textAlign: TextAlign.center,
                  'Get to know your weather\nmaps and radar precipitation\nforecast',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white), ),

                const SizedBox(height: 60),

                SizedBox(
                  width: size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(
                      )));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),

                   ],
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
