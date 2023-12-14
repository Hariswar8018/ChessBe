import 'dart:math';

import 'package:chess/fight/add_calender.dart';
import 'package:chess/fight/mycode.dart';
import 'package:chess/fight/challenge.dart';
import 'package:chess/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class My_List extends StatelessWidget {
  UserModel user;
   My_List({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Challenge Players"),
        ),
        body: Column(
            children : [
              ListTile(
                leading: Icon(Icons.calendar_month, color: Colors.greenAccent, size: 30),
                title: Text("Add to Calender"),
                onTap: () {
                  Navigator.push(
                  context, PageTransition(
                  child: Add_Calender(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
              ));
                },
                subtitle: Text("Add Alarm to Calender"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle,color: Colors.blueAccent, size: 30),
                title: Text("Fight"),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Challenge(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));
                },
                subtitle: Text("Already in spot? Let's Fight"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.code, color: Colors.purpleAccent, size: 30),
                title: Text("My Code"),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: MyCode(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));
                  /*final Uri _url = Uri.parse('https://chessmons.com/privacy/');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }*/
                },
                subtitle: Text("Check your Code for Verification"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
            ]
        )
    );
  }
}
