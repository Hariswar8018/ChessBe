import 'dart:convert';
import 'package:chess/Google/map_card.dart';
import 'package:chess/cards/student_full_card.dart';
import 'package:chess/first/login.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
import 'package:chess/fight/my_list.dart';
import 'package:chess/main%20page/chat.dart';
import 'package:chess/models/message_models.dart';
import 'package:chess/models/usermodel.dart';
import 'package:chess/providers/declare.dart';
import 'package:chess/subpages_messages_club/message_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool emojiShowing = false;

  final Fire = FirebaseFirestore.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Messages> _list = [];
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController textcon = TextEditingController();

  String getConversationId(String id) {
    return user!.uid.hashCode <= id.hashCode ? '${user?.uid}_$id' : '${id}_${user?.uid}';
  }

  Future<void> sendMessage(UserModel user1, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Messages messages = Messages(
        read: 'me',
        told: user!.uid,
        from: widget.user.uid,
        mes: msg,
        type: Type.text,
        sent: time);

    await _firestore
        .collection('Chat/${getConversationId('${user1.uid}')}/messages/')
        .doc(time)
        .set(messages.toJson(Messages(
            read: 'me',
            told: user1.uid,
            from: widget.user.uid,
            mes: msg,
            type: Type.text,
            sent: time)));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(UserModel user3) {
    print(user3.uid);
    print(user!.uid);
    return _firestore
        .collection('Chat/${getConversationId(user3.uid)}/messages/').orderBy('sent', descending: true)
        .snapshots();
  }

  Future<void> updateStatus(Messages message) async {
    _firestore
        .collection('Chat/${getConversationId('${message.from}')}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration : BoxDecoration(
          color : Colors.white,
          image : DecorationImage(
            image : AssetImage("assets/Diseño sin título_page-0001.jpg"), opacity: 0.2
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _AppBar(),
            backgroundColor: Colors.white70,
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return SizedBox(
                          height: 10,
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => Messages.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: _list.length, reverse: true,
                            padding: EdgeInsets.only(top: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: _list[index],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpLlegCjooVrcSfz0t1wQDTQc5-ozXoDWp7b9iItXB6sIajSyNGiVDKVgUtPU2z6lg-eA&usqp=CAU",
                                  height: 150,
                                ),
                                Text("Say Hi to each other 👋",
                                    style: TextStyle(fontSize: 23)),
                              ],
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
              _ChatInput(),
              Visibility(
                visible: emojiShowing!,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EmojiKeyboard(
                      emotionController: controller,
                      emojiKeyboardHeight: 300,
                      showEmojiKeyboard: emojiShowing,
                      darkMode: false),
                ),
              ),
            ],
          ),
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
      return '${DateFormat.E().format(dateTime)}, ${DateFormat.jm().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.month == now.month) {
      // Same month
      return '${DateFormat.MMMd().format(dateTime)}, ${DateFormat.jm().format(dateTime)}';
    } else {
      // Others
      return '${DateFormat.yMMM().format(dateTime)}';
    }
  }

  Widget _AppBar() {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: Ucard(
                user: widget.user,
              ),
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 800)));
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.user.Pic_link),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width / 3 + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.Name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
                Text(
                  "Last Online : " + formatDateTime(widget.user.lastloginn),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: My_List(
                        user: widget.user,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 400)));
            },
            child: SvgPicture.asset(
              "assets/svg/sword-war-svgrepo-com.svg",
              semanticsLabel: 'Acme Logo',
              width: 30,
            ),
          ),
          SizedBox(
            width: 19,
          ),
          InkWell(
            onTap : (){
              Navigator.push(
                  context, PageTransition(
                  child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: widget.user.Lat ,
                    ulong: widget.user.Lon, uName: widget.user.Name, uPic: widget.user.Pic_link, mPic: _user.Pic_link,
                  ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
              ));
    },
            child: SvgPicture.asset(
              "assets/svg/location-maps-navigation-svgrepo-com.svg",
              semanticsLabel: 'Acme Logo',
              width: 30,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          SvgPicture.asset(
            "assets/svg/preferences-options-settings-gear-svgrepo-com.svg",
            semanticsLabel: 'Acme Logo',
            width: 30,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  final Widget svg = SvgPicture.asset(
    "assets/svg/sword-war-svgrepo-com.svg",
    semanticsLabel: 'Acme Logo',
    width: 20,
  );

  Widget _ChatInput() {
    final TextEditingController _controller = TextEditingController();


    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    _onBackspacePressed() {
      _controller
        ..text = _controller.text.characters.toString()
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));
    }


    String s = " ";
    return Column(
      children: [
        Container(
            height: 66.0,
            color: Colors.blue,
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (FocusScope.of(context).hasFocus) {
                          FocusScope.of(context).unfocus();
                        }
                        if(emojiShowing){
                          emojiShowing = false;
                        }
                        else{
                          emojiShowing = true;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                        controller: controller,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      onChanged: ((value) {
                        s = value;
                      }),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                      onPressed: () {
                        if (s.isNotEmpty) {
                          s = controller.text ;
                          sendMessage(widget.user,s);
                          setState(() {
                            s = " ";
                            controller.clear();
                          });
                        }
                        // send message
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            )),
      ],
    );
  }
}