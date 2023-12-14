import 'package:chess/subpages_messages_club/chatpage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chess/models/usermodel.dart';
import 'package:flutter/foundation.dart' as foundation;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState() => ChatState();
}


class ChatState extends State<Chat> {
  List<UserModel> list = [];
  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Chat with Friends", style: TextStyle(color: Colors.black),)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: Fire.collection('users').orderBy('lastloginn', descending: true).snapshots(),
        builder: ( context,  snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center( child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs ;
              list = data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: 5),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return ChatUser(user: list[index],);
                },);
          }
        },
      ),
    );
  }
}



class ChatUser extends StatefulWidget {
  final UserModel user;
  const ChatUser({Key? key, required this.user}) : super(key: key);
  @override
  State<ChatUser> createState() => ChatUserState();
}
class ChatUserState extends State<ChatUser> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, PageTransition(
              child: ChatPage(user: widget.user,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
          ));
        },
        child: ListTile(
          title: Text(widget.user.Name),
          subtitle: Text(widget.user.Email, maxLines: 1,),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.user.Pic_link),
          ),
          trailing: Text( formatDateTime(widget.user.lastloginn) ),
        ),
      ),
    );
  }


  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();

    if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      // Same day
      return '${DateFormat.jm().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.weekday == now.weekday && dateTime.isAfter(now.subtract(Duration(days: 7)))) {
      // Same week
      return '${DateFormat.E().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.month == now.month) {
      // Same month
      return '${DateFormat.MMMd().format(dateTime)}';
    } else {
      // Others
      return '${DateFormat.yMMM().format(dateTime)}';
    }
  }

  void main() {
    // Example usage:
    String dateTimeString = '2023-11-12 20:55:28.614840';
    String formattedString = formatDateTime(dateTimeString);

    print(formattedString);
  }
}
