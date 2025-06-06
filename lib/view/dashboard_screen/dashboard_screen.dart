import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/view_model/service/weather_service.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {


  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late Future<WeatherModel> weathermodel;
  TextEditingController cityNameController = TextEditingController(text: 'Delhi');



  @override
  void initState() {
    super.initState();
    weathermodel = WeatherService().getWeather(cityNameController.text.trim());
  }



  void fetchWeather() {
    String cityName = cityNameController.text.trim();

    setState(() {
      weathermodel = WeatherService().getWeather(cityName);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF0A0E21),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white24,
                        blurRadius: 0.5,
                        spreadRadius: 1
                    )]
              ),
              child: Icon(Icons.menu,color: Colors.white,),
            ),
            Spacer(),

            Icon(Icons.location_on_sharp,color: Colors.white,),
            const SizedBox(width: 5,),
            FutureBuilder(
              future: weathermodel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // or any loading widget
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.name.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Text(
                    'No data',
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            ),

            const SizedBox(width: 5,)

          ],
        ),
      ),


      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text('About Today',style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w600),),


                  const SizedBox(height: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [



                      Container(
                        padding: EdgeInsets.all(20),
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [new BoxShadow(
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
                        FutureBuilder<WeatherModel>(
                        future: weathermodel,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;


                            final localDate = DateTime.parse(data.localtime);
                            final formattedDate = DateFormat('EEEE, dd MMMM').format(localDate);

                            return Text(
                              formattedDate,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Text('No data', style: TextStyle(color: Colors.white));
                          }
                        },
                      ),


                          const SizedBox(height: 10),


                          FutureBuilder<WeatherModel>(
                            future: weathermodel,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(color: Colors.white),
                                );
                              } else if (snapshot.hasData) {
                                final data = snapshot.data!;
                                return Text(
                                  '${data.tempC.toDouble()}°C',
                                  style: GoogleFonts.poppins(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                );
                              } else {
                                return Text(
                                  'No data',
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                            },
                          ),


                          const SizedBox(height: 30),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 color: Colors.white.withOpacity(0.2),
                                 borderRadius: BorderRadius.circular(20)
                               ),

                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 5),
                                      width: 90,
                                     child: Image.asset('assets/images/thunder.png'),
                                   ),
                                   const SizedBox(height: 10,),
                                   FutureBuilder<WeatherModel>(
                                     future: weathermodel,
                                     builder: (context, snapshot) {
                                       if (snapshot.connectionState == ConnectionState.waiting) {
                                         return CircularProgressIndicator();
                                       } else if (snapshot.hasError) {
                                         return Text(
                                           'Error: ${snapshot.error}',
                                           style: TextStyle(color: Colors.white),
                                         );
                                       } else if (snapshot.hasData) {
                                         final data = snapshot.data!;
                                         return Text(
                                           '${data.cloud.toString()}%',
                                           style: GoogleFonts.poppins(
                                               fontSize: 16,
                                               fontWeight: FontWeight.w600,
                                               color: Colors.white),
                                         );
                                       } else {
                                         return Text(
                                           'No data',
                                           style: TextStyle(color: Colors.white),
                                         );
                                       }
                                     },
                                   ),

                                   const SizedBox(height: 5,),
                                   Text('Rain',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
                                 ],
                               ),
                             ),
                             Container(
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color: Colors.white.withOpacity(0.2),
                                   borderRadius: BorderRadius.circular(20)
                               ),

                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 5),
                                     width: 90,
                                     child: Image.asset('assets/images/wind.png'),
                                   ),
                                   const SizedBox(height: 10,),
                                     FutureBuilder<WeatherModel>(
                                       future: weathermodel,
                                       builder: (context, snapshot) {
                                         if (snapshot.connectionState == ConnectionState.waiting) {
                                           return CircularProgressIndicator();
                                         } else if (snapshot.hasError) {
                                           return Text(
                                             'Error: ${snapshot.error}',
                                             style: TextStyle(color: Colors.white),
                                           );
                                         } else if (snapshot.hasData) {
                                           final data = snapshot.data!;
                                           return Text(
                                             '${data.wind.toString()} km/h',
                                             style: GoogleFonts.poppins(
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.white),
                                           );
                                         } else {
                                           return Text(
                                             'No data',
                                             style: TextStyle(color: Colors.white),
                                           );
                                         }
                                       },
                                     ),
                                   const SizedBox(height: 5,),
                                   Text('Wind',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
                                 ],
                               ),
                             ),
                             Container(
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color: Colors.white.withOpacity(0.2),
                                   borderRadius: BorderRadius.circular(20)
                               ),

                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 5),
                                     width: 90,
                                     child: Image.asset('assets/images/rain2.png'),
                                   ),
                                   const SizedBox(height: 10,),
                                   FutureBuilder<WeatherModel>(
                                     future: weathermodel,
                                     builder: (context, snapshot) {
                                       if (snapshot.connectionState == ConnectionState.waiting) {
                                         return CircularProgressIndicator();
                                       } else if (snapshot.hasError) {
                                         return Text(
                                           'Error: ${snapshot.error}',
                                           style: TextStyle(color: Colors.white),
                                         );
                                       } else if (snapshot.hasData) {
                                         final data = snapshot.data!;
                                         return Text(
                                           '${data.humidity.toString()}%',
                                           style: GoogleFonts.poppins(
                                               fontSize: 16,
                                               fontWeight: FontWeight.w600,
                                               color: Colors.white),
                                         );
                                       } else {
                                         return Text(
                                           'No data',
                                           style: TextStyle(color: Colors.white),
                                         );
                                       }
                                     },
                                   ),
                                   const SizedBox(height: 5,),
                                   Text('Humidity',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
                                 ],
                               ),
                             )
                           ],
                         ),

                          const SizedBox(height: 50),


                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: cityNameController,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  cursorColor: Colors.white70,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Location',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    hoverColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.white70
                                      )
                                    )
                                  ),
                                ),
                              ),

                              const SizedBox(width: 20,),

                              SizedBox(
                                  height: 55,
                                  child: ElevatedButton(

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff38ACFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        )
                                      ),
                                      onPressed: () =>
                                        fetchWeather()
                                      , child: Text('Confrim',style: TextStyle(color: Colors.white),)))


                            ],
                          )

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
