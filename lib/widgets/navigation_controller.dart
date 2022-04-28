import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/reservationpage.dart';

class NavigationController extends StatelessWidget {
  final int index;
  const NavigationController({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Prenotati',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_rtl_rounded),
          label: 'Le tue prenotazioni',
        ),
      ],
      currentIndex: index,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blue[60],
      onTap: (index) {
        index == 0 ? Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())) : Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationPage()));
      },
    );
  }
}
