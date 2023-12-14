import 'package:chess/models/reviews_model.dart';
import 'package:chess/subpages_messages_club/chatpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/foundation.dart' as foundation;

class Review extends StatefulWidget {
  String collection;
  String doc;

   Review({Key? key, required this.collection, required this.doc}) : super(key: key);
  @override
  State<Review> createState() => ReviewState();
}

class ReviewState extends State<Review> {
  bool b = false ;
  List<ReviewModel> list = [];
  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(" Reviews given", style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){

          }, child: Text("Give Review")),
        ],
      ),
      body: StreamBuilder(
        stream: Fire.collection(widget.collection).doc(widget.doc).collection('Reviews').orderBy( b ?'TimeN' : 'rating' ).snapshots(),
        builder: ( context,  snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center( child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs ;
              list = data?.map((e) => ReviewModel.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(bottom: 10),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return ChatUser(user: list[index],);
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action when the button is pressed
          setState(() {
            b = !b ;
          });
        },
        child: b ? Icon(CupertinoIcons.calendar , color: Colors.white) : Icon(CupertinoIcons.star_slash_fill , color: Colors.white),
        backgroundColor: Color(0xffff79ac), // Customize the button color
      ),
    );
  }
}



class ChatUser extends StatefulWidget {
  final ReviewModel user;
  const ChatUser({Key? key, required this.user}) : super(key: key);
  @override
  State<ChatUser> createState() => ChatUserState();
}
class ChatUserState extends State<ChatUser> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.Pic_link,),
                radius: 25,
              ),
              Text(" " + widget.user.Name, style: TextStyle(fontSize: 19),),
              Spacer(),
              Text(widget.user.Time, style: TextStyle(fontSize: 13, color: Colors.grey),),
            ],
          ),
        ),
        Text("    " + widget.user.Title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
        Text("    " + widget.user.Bio, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
        Padding(
          padding: const EdgeInsets.only(left : 15.0),
          child: Row(
            children : generateStars(widget.user.rating) ,
          ),
        ),
      ],
    );
  }

  List<Widget> generateStars( int numberOfStars) {
    List<Widget> stars = [];
    int count = 1;

    // Use a while loop to add stars until the desired count
    while (count < numberOfStars) {
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: 30.0,
      ));
      count++;
    }
    return stars;
  }
}
