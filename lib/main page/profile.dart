import 'package:chess/MY_Profile/Club_Not_Update.dart';
import 'package:chess/MY_Profile/TeacherNot.dart';
import 'package:chess/MY_Profile/club_navigation.dart';
import 'package:chess/MY_Profile/club_or_not.dart';
import 'package:chess/MY_Profile/teacher_navigation.dart';
import 'package:chess/first/login.dart';
import 'package:chess/models/usermodel.dart';
import 'package:chess/more_settings/support.dart';
import 'package:chess/more_settings/teacher_or_not.dart';
import 'package:chess/providers/declare.dart';
import 'package:chess/update/user_profile_before_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  initState() {
    super.initState();
    vq();
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height : 190,
                width : MediaQuery.of(context).size.width,
                decoration : BoxDecoration(
                  color : Colors.white,
                  image : DecorationImage(
                      image : NetworkImage("https://c1.wallpaperflare.com/preview/714/489/198/chess-chess-board-game-board-flag.jpg"), opacity: 0.8,
                    fit: BoxFit.cover,
                  ), 
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      _user!.Pic_link,
                    ),
                    minRadius: 50,
                    maxRadius: 60,
                  ),
                ),
              ),
              SizedBox(height : 15),
              ListTile(
                leading: Icon(Icons.account_circle_sharp, color: Colors.black, size: 30,),
                title: Text("My Account"),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Before_Update(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
                  ));
                },
                subtitle: Text("See your Account, Edit or Delete It"),
                splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.redAccent, size: 30),
                title: Text("Learn More"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://chessmons.com/');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                },
                subtitle: Text("Learn More about us & the App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              /*ListTile(
                leading: Icon(Icons.my_library_books_sharp, color: Colors.greenAccent, size: 30),
                title: Text("Teacher Profile"),
                onTap: () async {
                  bool t = false;
                  await FirebaseFirestore.instance
                      .collection('teacher')
                      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((value) => value.size > 0 ? t = true : t = false );
                  if(t){
                    Navigator.push(
                        context, PageTransition(
                        child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));

                  }else{
                    Navigator.push(
                        context, PageTransition(
                        child: TecaherNot(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  }
                },
                subtitle: Text("Check your Teacher Dashboard"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),*/
              ListTile(
                leading: Icon(Icons.people_outline_sharp,color: Colors.blueAccent, size: 30),
                title: Text("Chess Places Profile"),
                onTap: () async {
                  bool t = false;
                  await FirebaseFirestore.instance
                      .collection('clubs')
                      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((value) => value.size > 0 ? t = true : t = false );
                  if(t){
                    Navigator.push(
                        context, PageTransition(
                        child: Club_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));

                  }else{
                    Navigator.push(
                        context, PageTransition(
                        child: ClubNot(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  }

                },
                subtitle: Text("Check your Club Activity"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.purpleAccent, size: 30),
                title: Text("Privacy"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://chessmons.com/privacy/');
                  if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Check how Privacy is Managed"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.sd_storage, color: Colors.orange, size: 30),
                title: Text("Storage"),
                onTap: () async {

                  await DefaultCacheManager().emptyCache();
                },
                subtitle: Text("Clear your Cache"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.support, color: Colors.green, size: 30),
                title: Text("Support"),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Support(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Contact Help and Support"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent, size: 30),
                title: Text("Log Out"),
                onTap: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });
                },
                subtitle: Text("Log Out from this App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              Text("CHESS BEE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
              Text("Made with ❤️ in Spain & India", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Image.asset("assets/chessbe.jpg", height: 80,),
              Text("ChessBe version : 1.2", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
