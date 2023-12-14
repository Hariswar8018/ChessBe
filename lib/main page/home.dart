import 'dart:math';
import 'package:chess/cards/student_full_card.dart';
import 'package:chess/fight/my_list.dart';
import 'package:chess/first/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chess/Google/map_card.dart';
import 'package:chess/Google/my_location.dart';
import 'package:chess/providers/declare.dart';
import 'package:chess/update/user_profile_before_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chess/models/message_models.dart';
import 'package:chess/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_tinder_swipe/flutter_tinder_swipe.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chess/subpages_messages_club/chatpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String h = " ";

  initState() {
    super.initState();
    vq();
    setState((){

    });
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      h  = prefs.getString('State') ?? "Canary Islands";
    });
    await _userprovider.refreshuser();
    DateTime now = DateTime.now();
    String s = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(s)
        .update({
      "lastloginn" : now.toString() ,
    });
  }
  List<UserModel> _list = [];
  CardController controller = CardController();
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text("Market Corner")),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:
                Center(child: Text("Find Everything in our Market. Top Below to view our Store")),
          )
        ],
      ),
      actions: <Widget>[
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
            width: MediaQuery.of(context).size.width - 132,
            child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("View Store",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextButton.icon(
            icon: Icon(
              Icons.not_listed_location,
              size: 22,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(
                  context, PageTransition(
                  child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
              ));
            },
            label: Text(
              h,
              style: TextStyle(color: Colors.red, fontSize: 13),
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, PageTransition(
                    child: Before_Update(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                ));
              },
              icon: Icon(Icons.edit, color : Colors.pinkAccent)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, PageTransition(
                    child: My_Location(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                ));
              },
              icon: Icon(Icons.share_location, color : Colors.blueAccent)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              icon: Icon(Icons.shop, color : Colors.red)),
          SizedBox(width : 5),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').where("State", isEqualTo : h ).get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  _list =
                      data?.map((e) => UserModel.fromJson(e.data())).toList() ??
                          [];
                  if(_list.isEmpty){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png", height: 150),
                          Text("Sorry, No one's in Your City", style: TextStyle(fontSize : 22, fontWeight : FontWeight.w600)),
                          Text("Why don't you Share your App to your Friends", style: TextStyle(fontSize : 14, fontWeight : FontWeight.w500)),
                        SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){}, child:Text("Share App now >>"),),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){
                            Navigator.push(
                                context, PageTransition(
                                child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                            ));
                            setState(() {

                            });
                          }, child:Text("Use Another City"),),
                        ],
                      )
                    );
                  }
                 return  CardSwiper(
                      cardsCount: _list.length,
                      cardBuilder:
                          (context, index, percentThresholdX, percentThresholdY) {
                        return Container(
                          child: ChatUser(user: _list[index]),
                        );
                      },
                  );
              }
            },
          ),
      ),
    );
  }
}

class ChatUser extends StatelessWidget {
  UserModel user;

  ChatUser({required this.user});

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 70,
      decoration: BoxDecoration(
        color: Colors.white, // specify the background color of the container
        borderRadius:
            BorderRadius.circular(20), // specify the border radius here
      ),
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  // specify the radius for the top-left corner
                  topRight: Radius.circular(
                      20), // specify the radius for the top-right corner
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      user.Pic_link,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "  " + user.Name,
                style:
                TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.black),/*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: ' ( ' + user.age + " ) ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    height: 50,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          // specify the radius for the top-left corner
                          bottomLeft: Radius.circular(
                              20), // specify the radius for the top-right corner
                        ),
                        color: Colors.black),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.star_rate_sharp,
                          color: Colors.white,
                          size: 14,
                        ),
                        label: Text("chess.com \n 4.1",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 13.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded, color: Colors.red),
                Text(" Distance : " + calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km"),
                SizedBox(
                  width: 25,
                ),
                Icon(Icons.directions_walk, color: Colors.blueAccent),
                Text("Time : " + calculateW(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " min"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 13.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.transgender_sharp, color: Colors.green),
                Text(" Gender : " + user.Gender),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.sentiment_satisfied_alt, color: Colors.purpleAccent),
                Text(" Talk : " + user.Talk),
              ],
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
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Ucard(user: user ,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                  ));
                },
                icon: Icon(CupertinoIcons.location_fill),
                label: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text("See Profile"),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  // Button text color
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blueAccent), // Button background color
                ),
              ),
              TextButton.icon(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: My_List(
                            user: user,
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 400)));
                },
                label: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text("Challenge"),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  // Button text color
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Button background color
                ),
              ),
            ],
          )
        ],
      ),
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

    if( distance > 100 ){
      return "100+" ;
    }
    // Format the distance as a string
    return distance.toStringAsFixed(1); // Adjust the precision as needed
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
    if( time  > 100 ){
      return "100+" ;
    }
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

