import 'package:chess/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

class Add_Calender extends StatefulWidget {
  UserModel user;
  Add_Calender({super.key, required this.user});

  @override
  State<Add_Calender> createState() => _Add_CalenderState();
}

class _Add_CalenderState extends State<Add_Calender> {
  DateTime nq = DateTime.now();

  void m(){
    final Event event = Event(
      title: 'Event title',
      description: 'Event description',
      location: 'Event location',
      startDate: nq,
      endDate: nq.add( Duration(minutes: 30)),
      iosParams: IOSParams(
        reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
        url: 'https://www.example.com', // on iOS, you can set url to your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [
          "${widget.user!.Email}"
        ], // on Android, you can add invite emails to your event.
      ),
    );
  }

  bool f = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add Event to Calender"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Center(child: Icon(Icons.calendar_month, size: 100, color: Colors.pink)),
          SizedBox(height:30,),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.red.shade100, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Title : Fight with " + widget.user.Name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              )),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade100, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description : Fight with " + widget.user.Name + " for ChessBe Game as decided on Today ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
              color: Colors.orange.shade100,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Location : " + widget.user.Location, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
              )),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.green.shade100,child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Date & Time : " + nq.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
          )),
          SizedBox(height:40,),
        f ?  SizedBox(height: 10,) : Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Border color
                width: 1.0, // Border width
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
                    onPressed: () {
                      DatePickerBdaya.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                            print('change $date');
                            setState(() {
                              nq = date ;
                            });
                          }, onConfirm: (date) {
                            setState(() {
                              f = true;
                              nq = date ;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.zh);
                    },
                    icon: Icon(Icons.calendar_today_outlined, color: Colors.white, size: 18),
                    label: Text(
                      'Choose Date / Time (Chinese)',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),)),
          f ? Center(
            child: Container(
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
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextButton.icon(
                        onPressed: () {
                          m();
                        },
                        icon:
                        Icon(Icons.calendar_today_rounded, color: Colors.black),
                        label: Text("Add to Calender",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))))),
          ) : SizedBox(height: 10,),
        ],
      ),
    );
  }
}
