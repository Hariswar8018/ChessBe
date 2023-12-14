import 'package:chess/first/onboarding.dart';
import 'package:chess/main%20page/navigation.dart';
import 'package:chess/providers/declare.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser ;
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MaterialApp(
      title: 'Chess Be',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: Future.delayed(Duration(seconds: 3)),
          builder: (ctx, timer) =>
          timer.connectionState == ConnectionState.done
              ? ( user == null ?  TestScreen() : Home() ) //Screen to navigate to once the splashScreen is done.
              : Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/chessbe.jpg'),
                  ),
                  Text("♟ Connecting Chess Players ♟", style : TextStyle(fontSize : 23, fontWeight : FontWeight.w800, fontStyle: FontStyle.italic))
                ],
              ),
            ),
          )),
    ),/*home: user == null ?  TestScreen() : Home(),*/
    );
  }
}