import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/dataprova/provareservations.dart';
import 'package:ripetizioni_mobile_app/model/reservation.dart';
import 'package:ripetizioni_mobile_app/model/course.dart';
import 'package:ripetizioni_mobile_app/widgets/reservation_lists.dart';
import 'package:ripetizioni_mobile_app/widgets/navigation_controller.dart';
import 'package:requests/requests.dart';
import 'package:ripetizioni_mobile_app/pages/login.dart';

class MyAppBar extends StatefulWidget {
  final bool back;
  final String title;
  @override
  _MyAppBarState createState() => _MyAppBarState();
  MyAppBar({required this.back, required this.title});
}

class _MyAppBarState extends State<MyAppBar> {
  
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 24),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            Requests.get('http://10.0.2.2:8080/Prenotazioni0_war/Logout');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ],
      automaticallyImplyLeading: widget.back,
    );
  }
}
