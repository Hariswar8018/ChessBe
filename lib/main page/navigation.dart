
import 'package:chess/main%20page/Teacher.dart';
import 'package:chess/main%20page/chat.dart';
import 'package:chess/main%20page/home.dart';
import 'package:chess/main%20page/learn.dart';
import 'package:chess/main%20page/profile.dart';
import 'package:chess/teacher_club/teacher_incoming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  void initState(){
    v();
  }
  String s = FirebaseAuth.instance.currentUser!.uid;
  void v() async{
    int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;

    // Convert milliseconds since epoch to DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String formattedDate = DateFormat('MMM d, HH:mm').format(dateTime);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(s)
        .update({
      "lastlogin": formattedDate,
    });
    print(formattedDate);
  }


  final user = FirebaseAuth.instance.currentUser;

  int currentTab=0;
  final Set screens ={
    HomePage(),
    Chat(),
    Clubs(),
    Profile(),
  };
  final PageStorageBucket bucket = PageStorageBucket();

  dynamic selected ;
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    Chat(),
    Learn(),
    Clubs(), Profile()
  ];
  var heart = false;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context){
    return WillPopScope(
        onWillPop: () async {
          // Show the alert dialog and wait for a result
          bool exit = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Exit App'),
                content: Text('Are you sure you want to exit?'),
                actions: [
                  ElevatedButton(
                    child: Text('No'),
                    onPressed: () {
                      // Return false to prevent the app from exiting
                      Navigator.of(context).pop(false);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      DateTime now = DateTime.now();
                      String s = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(s)
                          .update({
                        "lastloginn" : now.toString() ,
                      });
                      // Return true to allow the app to exit
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );

          // Return the result to handle the back button press
          return exit ?? false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageStorage(
            child: currentScreen,
            bucket: bucket,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4, color: Colors.white, surfaceTintColor: Colors.white,
            shadowColor:  Colors.white,
            child: Container(
              height: 20, color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      minWidth: 25, onPressed: (){
                    setState(() {
                      currentScreen = HomePage();
                      currentTab = 0;
                    });
                  },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_score,
                            color: currentTab == 0? Colors.black : Colors.grey, size: 23,
                          ),
                          Text("Players", style: TextStyle(color: currentTab == 0?  Colors.black :Colors.grey, fontSize: 12))
                        ],
                      )
                  ),
                  MaterialButton(
                      minWidth: 25, onPressed: (){
                    setState(() {
                      currentScreen = Chat();
                      currentTab = 1;
                    });
                  },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_2_fill,
                            color: currentTab == 1? Colors.black:Colors.grey, size: 23,
                          ),
                          Text("Chats", style: TextStyle(color: currentTab == 1? Colors.black:Colors.grey, fontSize: 12))
                        ],
                      )
                  ),
                 /* MaterialButton(
                    minWidth: 25, onPressed: (){
                    setState(() {
                      currentScreen = Learn();
                      currentTab = 2;
                    });
                  },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.book_solid ,
                          color: currentTab == 2? Colors.black:Colors.grey,size: 23,
                        ),
                        Text("Teachers", style: TextStyle(color: currentTab == 2? Colors.black:Colors.grey, fontSize: 12))
                      ],
                    ),
                  ),*/
                  MaterialButton(
                    minWidth: 25, onPressed: (){
                    setState(() {
                      currentScreen = Clubs();
                      currentTab = 3;
                    });
                  },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.suit_club_fill,
                          color: currentTab == 3? Colors.black:Colors.grey,size: 23,
                        ),
                        Text("Chess Places", style: TextStyle(color: currentTab == 3? Colors.black :Colors.grey,fontSize: 12))
                      ],
                    ),
                  ),
                  MaterialButton(
                      minWidth: 25, onPressed: (){
                    setState(() {
                      currentScreen = Profile();
                      currentTab = 4;
                    });
                  },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.person,
                            color: currentTab == 4? Colors.black:Colors.grey, size: 23,
                          ),
                          Text("User", style: TextStyle(color: currentTab == 4? Colors.black:Colors.grey, fontSize: 12))
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ));
  }



}
