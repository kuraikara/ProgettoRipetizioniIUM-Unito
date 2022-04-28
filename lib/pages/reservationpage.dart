import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/dataprova/provareservations.dart';
import 'package:ripetizioni_mobile_app/model/reservation.dart';
import 'package:ripetizioni_mobile_app/model/course.dart';
import 'package:ripetizioni_mobile_app/widgets/app_bar.dart';
import 'package:ripetizioni_mobile_app/widgets/reservation_lists.dart';
import 'package:ripetizioni_mobile_app/widgets/navigation_controller.dart';
import 'package:requests/requests.dart';
import 'package:ripetizioni_mobile_app/pages/login.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int index = 0;

  List<bool> isSelected = [true, false];

  List<Reservation> reservationAttive = [];
  List<Reservation> reservationPassate = [];

  @override
  void initState() {
    super.initState();
    fetchReservation();
  }

  Widget getList() {
    if (index == 0) {
      return ReservationsAttiveList(
        reservations: reservationAttive.reversed.toList(),
        reflesh: fetchReservation,
      );
    } else {
      return ReservationsPassateList(
        reservations: reservationPassate.reversed.toList(),
        reflesh: fetchReservation,
      );
    }
  }

  Future<void> fetchReservation() async {
    Reservation.fetchReservation().then((reservations) {
      setState(() {
        reservationAttive = [];
        reservationPassate = [];

        
        reservations.forEach((reservation) {
          if (reservation.stato == 'A') {
            reservationAttive.add(reservation);
          } else {
            reservationPassate.add(reservation);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      bottomNavigationBar: NavigationController(index: 1),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MyAppBar(back: true, title: 'Le tue prenotazioni')),
      body: RefreshIndicator(
        color: Colors.blue,
        displacement: 10.0,
        onRefresh: () => fetchReservation(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: ToggleButtons(
              onPressed: (int newindex) {
                setState(() {
                  if (newindex != index) {
                    isSelected[newindex] = true;
                    isSelected[index] = false;
                    index = newindex;
                  }
                });
              },
              isSelected: isSelected,
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Attive", style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Passate", style: TextStyle(fontSize: 20)),
                ),
              ],
            )),
          ),
          Expanded(
            child: getList(),
          )
        ]),
      ));
}
