import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/widgets/teaching_card.dart';
import 'package:ripetizioni_mobile_app/widgets/navigation_controller.dart';
import 'package:ripetizioni_mobile_app/model/teaching.dart';


class SubjectPage extends StatefulWidget {
  final int id;
  final String nome;
  
  const SubjectPage({ Key? key, required this.id, required this.nome}) : super(key: key);
  

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  /*
  List teaching = [
    [1, 'Simone', 'Multari', 'Giovedi' , 16.00],
    [2, 'Carlo', 'Magno', 'Giovedi' , 16.00],
    [3, 'Carlo', 'Magno', 'Venerdi' , 16.00],
  ];
  */
  
  List<TeachingsByProf> teaching = [];

  @override
  void initState() {
    super.initState();
    fetchTeaching();
  }

  Future<void> fetchTeaching() async {
    TeachingsByProf.fetchTeaching(widget.id).then((teaching) {
      setState(() {
        this.teaching = teaching;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ripezioni ' + widget.nome, style: TextStyle(fontSize: 24),),
      ),
      bottomNavigationBar: NavigationController(index: 0),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Colors.blue,
              displacement: 10.0,
              onRefresh: () => fetchTeaching(),
              child: ListView.builder(
                itemCount: teaching.length,
                itemBuilder: (context, index) {
                  return TeachingCard(
                    nomeDocente: teaching[index].nomeDocente,
                    cognomeDocente: teaching[index].cognomeDocente,
                    aggiornaInsegnamenti: fetchTeaching,
                    teachings: teaching[index].teachings,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}