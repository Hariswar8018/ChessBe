import 'dart:math';

import 'package:chess/Google/map_card.dart';
import 'package:chess/Google/paypal.dart';
import 'package:chess/cards/reviews.dart';
import 'package:chess/models/usermodel.dart';
import 'package:chess/providers/declare.dart';
import 'package:chess/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chess/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Ucard extends StatelessWidget {
  UserModel user;

  Ucard({super.key, required this.user});



  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(title: Text(user.Name + " Profile")),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              // specify the radius for the top-left corner
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              // specify the radius for the top-right corner
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.Pic_link),
                    radius: 85,
                  ),
                  SizedBox(height : 15),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 2.0, // Border width
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // specify the radius for the top-left corner
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            // specify the radius for the top-right corner
                          ),
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context, PageTransition(
                                      child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: user.Lat ,
                                        ulong: user.Lon, uName: user.Name, uPic: user.Pic_link, mPic: _user.Pic_link,
                                      ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                                  ));
                                },
                                icon: Icon(CupertinoIcons.location_fill,
                                    color: Colors.white),
                                label: Text("Locate Me",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))))),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 2.0, // Border width
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // specify the radius for the top-left corner
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            // specify the radius for the top-right corner
                          ),
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            child: TextButton.icon(
                                onPressed: () async {
                                  Navigator.push(
                                      context, PageTransition(
                                      child: ChatPage(user: user,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                                  ));
                                },
                                icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                                    color: Colors.black),
                                label: Text("Message Me",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))))),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 27,
                  ),
                  Container(

                    decoration: BoxDecoration(
                      color : Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ListTile(
                      leading:  Icon(Icons.person_pin, size: 25, color: Colors.white),
                      title:  Text(
                        " Name : " ,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      trailing:  Text(
                         user.Name,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.translate,
                        size: 25, color: Colors.blueAccent),
                    title: Text(
                      "  Speaks : " ,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    trailing: Text(
                       user.Language,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color : Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.transgender_sharp,
                          size: 25, color: Colors.orange),
                      title: Text(
                        "  Gender : ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      trailing: Text(
                         user.Gender,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading:  Text(
                      " ♛        Chess Level : ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    trailing:  Text(
                       user.Chess_Level,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color : Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.agriculture,
                          size: 25, color: Colors.pink),
                      title: Text(
                        "  Age : " ,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      trailing: Text(
                         user.age,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Won : " + user.Won.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)),
                        Text("Lose : " + user.Lose.toString(), style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w800)),
                        Text("Draw : " + user.Draw.toString(), style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 1, left : 5, right :5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.social_distance_rounded, color : Colors.red),
                        Text("Distance : " + calculateDistance(user.Lat, user.Lon, _user!.Lat, _user!.Lon) + " km", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)),
                        Spacer(),
                        Icon(Icons.directions_walk, color : Colors.green),
                        Text("Time : " + calculateW(user.Lat, user.Lon, _user!.Lat, _user!.Lon) + " hr", style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1, bottom: 1, left : 5, right :5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.car_crash, color : Colors.orange),
                        Text("HighWay : " + calculateC(user.Lat, user.Lon, _user!.Lat, _user!.Lon, true) + " hr", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w800)),
                        Spacer(),
                        Icon(Icons.car_rental, color : Colors.blue),
                        Text("FreeWay : " + calculateC(user.Lat, user.Lon, _user!.Lat, _user!.Lon, false) + " hr", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  user.Won > user.Lose ?  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 30, bottom: 20, right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // specify the radius for the top-left corner
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            // specify the radius for the top-right corner
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.auto_graph,
                              size: 35, color: Colors.deepOrange),
                          title: Text(
                            " Super Player ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            " This User have good Winning History ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ) : SizedBox(height : 20),


                  Text(
                    "About ${user.Name}",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(user.Bio),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      /*persistentFooterButtons: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
              color: Color(0xffff79ac),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                // specify the radius for the top-left corner
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                // specify the radius for the top-right corner
              ),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: Paypal(name: user.Name, amount: user.Price_N, secretkey: user.secretkey, b: true, clientId: user.clientId, ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                      ));
                    },
                    child: Text("Book Lesson",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))))),
      ],*/
    );
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    // Format the distance as a string
    return distance.toStringAsFixed(2); // Adjust the precision as needed
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  void main() {
    // Example usage:
    double lat1 = 40.7128; // Latitude of the first position
    double lon1 = -74.0060; // Longitude of the first position

    double lat2 = 34.0522; // Latitude of the second position
    double lon2 = -118.2437; // Longitude of the second position

    String distance = calculateDistance(lat1, lon1, lat2, lon2);

    print('Distance between the two positions: $distance km');
  }

  String calculateW(double lat1, double lon1, double lat2, double lon2) {
    const walkingSpeed = 5.0; // Average walking speed in km/h

    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * walkingSpeed;

    return time.toStringAsFixed(1);
  }
  String calculateC( double lat1, double lon1, double lat2, double lon2 , bool isHighway ) {
    // Set average car speeds based on the type of road
    double carSpeed = isHighway ? 100.0 : 40.0; // Adjust speeds as needed
    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * carSpeed;

    return time.toStringAsFixed(1);
  }
  double calculateDistance1(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    // Format the distance as a string
    return distance ; // Adjust the precision as needed
  }
}


