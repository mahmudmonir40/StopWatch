import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stop Watch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //now let's create the logic of the app
  int seconds = 0, minutes = 0, hour = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHour = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //creating the stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //creating the reset function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hour = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHour = "00";

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHour: $digitMinutes: $digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //creating the start time function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHour = hour;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHour++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hour = localHour;

        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "StopWatch App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "$digitHour : $digitMinutes : $digitSeconds",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 52.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 400.0,
              decoration: BoxDecoration(
                color: Color(0xFF323F68),
                borderRadius: BorderRadius.circular(8.0),
              ),

              //now let's add a list builder
              child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n${index + 1}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),

                          Text(
                            "${laps[index]}",
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                    child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  child: Text(
                    (!started) ? "Start" : "Pause",
                    style: TextStyle(color: Colors.white),
                  ),
                )),


                SizedBox(
                  height: 8.0,
                ),
                IconButton(
                  onPressed: () {
                    addLaps();
                  },
                  icon: Icon(Icons.flag),
                  color: Colors.white,
                ),


                Expanded(
                    child: RawMaterialButton(
                  onPressed: () {
                    reset();
                  },
                  fillColor: Colors.blue,
                  shape: StadiumBorder(),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
              ],
            )
          ],
        ),
      )),
    );
  }
}
