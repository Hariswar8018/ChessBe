import 'package:chess/cards/reviews.dart';
import 'package:chess/models/club_model.dart';
import 'package:chess/models/picture.dart';
import 'package:chess/models/usermodel.dart';
import 'package:chess/subpages_messages_club/chatpage.dart';
import 'package:chess/subpages_messages_club/club_chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chess/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Club_Full extends StatelessWidget {
  String names ;

  ClubModel user;
  Club_Full({super.key, required this.user, required this.names});
  final String s = FirebaseAuth.instance.currentUser!.uid ?? "h";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation : 0,
      ),
      body : Container(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.width - 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    /*borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // specify the radius for the top-left corner
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      // specify the radius for the top-right corner
                    ),*/
                    image: DecorationImage(
                        image: NetworkImage(
                          user!.Pic_link,
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Text(user.Name ,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 20, color: Colors.greenAccent),
                    Text(
                      "  In " + user.Location,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.person_pin, size: 20, color: Colors.yellow),
                    Text(
                      "  Organised by " + user.HName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.person_pin_sharp, size: 20, color: Colors.orange),
                    Text(
                      "  Hosted by " + user.HName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20, color: Colors.deepOrange),
                    Text(
                      " " +
                          user.Clublist.length.toString() +
                          " Active Members",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.translate, size: 20, color: Colors.blueAccent),
                    Text(
                      "  Language " + user.Language,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 19.0, top: 10),
                child: Row(
                    children:[
                      Text("Social Links : ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SocialMediaButton.whatsapp(
                          onTap: () async {
                            final Uri _url = Uri.parse(user.whatsapp);
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          size: 20, color: Colors.green
                      ),
                      SocialMediaButton.facebook(
                          onTap: () async {
                            final Uri _url = Uri.parse(user.facebook);
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          size: 20, color: Colors.blue
                      ),
                      SocialMediaButton.instagram(
                          onTap: () async {
                            final Uri _url = Uri.parse(user.instagram);
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          size: 20, color: Colors.orangeAccent
                      ),
                      SocialMediaButton.twitter(
                          onTap: () async {
                            final Uri _url = Uri.parse(user.twitter);
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          size: 20, color: Colors.blueAccent
                      ),
                      SocialMediaButton.dribbble(
                          onTap: () async {
                            final Uri _url = Uri.parse(user.discord);
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          size: 20, color: Colors.black
                      ),
                    ]
                ),
              ),
              SizedBox(height: 8,),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
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
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextButton.icon(
                            onPressed: () async {
                              String g = FirebaseAuth
                                  .instance.currentUser!.uid ??
                                  "7";
                              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                              if (user.Clublist.contains(g)) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ChatPageClub(user: user, name_person: names,),
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 200)));
                              } else {
                                // else we need to add uid to the likes array
                                await _firestore
                                    .collection('clubs')
                                    .doc(user.uid)
                                    .update({
                                  'ClubList': FieldValue.arrayUnion([g])
                                });
                              }
                            },
                            icon: Icon(CupertinoIcons.person_add,
                                color: Colors.black),
                            label: Text( user.Clublist.contains(s)
                                ? "Chat Now"
                                : " Join Now ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
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
                              try{
                                String uidToSearch = user!.uid; // Replace with the actual uid you want to search
                                UserModel? user2 = await getUserByUid(uidToSearch);
                                if (user2 != null) {
                                  print("User found: His Name }");
                                  Navigator.push(
                                      context, PageTransition(
                                      child: ChatPage(user: user2,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                                  ));
                                } else {
                                  print("User not found");
                                }
                              }catch(e){
                                print(e);
                              }
                            },
                            icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                                color: Colors.black),
                            label: Text("Message Host",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                            width: MediaQuery.of(context).size.width/2 - 30,
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context, PageTransition(
                                      child: Picture(collection: 'clubs', doc: user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                                  ));
                                },
                                icon: Icon(CupertinoIcons.camera_fill,
                                    color: Colors.pink),
                                label: Text("Pictures",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))))),
                  ),
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
                            width: MediaQuery.of(context).size.width/2 - 30,
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context, PageTransition(
                                      child: Review(collection: 'clubs', doc: user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                                  ));
                                },
                                icon: Icon(CupertinoIcons.star_lefthalf_fill,
                                    color: Colors.yellow),
                                label: Text("Reviews",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))))),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
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
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.location_fill,
                                color: Colors.black),
                            label: Text("Locate Group",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              SizedBox(height: 20,),
              Text("    About Group : ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Padding(
                  padding:
                  const EdgeInsets.only(left: 19.0, top: 10, right: 19, bottom : 20),
                  child: Text(
                    user.Bio,
                  )),

            ],
          ),
        ),
      ),
    );
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
        return user;
      } else {
        // No document found with the given uid
        return null;
      }
    } catch (e) {
      print("Error fetching user by uid: $e");
      return null;
    }
  }
}
