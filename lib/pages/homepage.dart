import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/model/course.dart';
import 'package:ripetizioni_mobile_app/pages/login.dart';
import 'package:ripetizioni_mobile_app/widgets/subject_card.dart';
import 'dart:math';
import 'package:ripetizioni_mobile_app/model/reservation.dart';
import 'package:ripetizioni_mobile_app/widgets/navigation_controller.dart';
import 'package:ripetizioni_mobile_app/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.cyan,
    Colors.indigo,
    Colors.lime,
    Colors.teal,
    Colors.amber,
    Colors.deepPurple,
    Colors.brown,
    Colors.grey,
    Colors.indigoAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyanAccent,
    Colors.indigoAccent,
    Colors.limeAccent,
    Colors.tealAccent,
    Colors.amberAccent,
    Colors.deepPurpleAccent
  ];
  List<Course> course_list = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchNotifiche();
  }

  Future<void> fetchCourses() async {
    Course.fetchCourses().then((courses) {
      setState(() {
        course_list = courses;
      });
    });
  }

  Future<void> fetchNotifiche() async {
    Reservation.fetchNotifiche().then((notifiche) {
      setState(() {
        if (notifiche != "")
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Nuovi messaggi"),
              content: Text(notifiche),
              actions: <Widget>[
                TextButton(
                    child: Text("Ok"),
                    onPressed: () => {
                          Navigator.pop(context),
                        }),
              ],
            ),
          );
        ;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
            child: MyAppBar(back: false, title: "Corsi disponibili"),
            preferredSize: Size.fromHeight(60)),
        bottomNavigationBar: NavigationController(index: 0),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          color: Colors.blue,
          displacement: 10.0,
          onRefresh: () => fetchCourses(),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // list of cards
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    "Seleziona una materia per prenotarti",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: ListView.builder(
                      itemCount: course_list.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return SubjectCard(
                          subjectId: course_list[index].id,
                          subjectName: course_list[index].nome,
                          subjectColor: colors[Random().nextInt(colors.length)],
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
}
