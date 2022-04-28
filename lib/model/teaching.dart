import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class Teaching {
  final int id;
  final String giorno;
  final double ora;
  final bool isAttivo;

  Teaching({
    required this.id,
    required this.giorno,
    required this.ora,
    required this.isAttivo,
  });

  static Future<bool> prenota(int idInsegnamento) async {
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';

    //fetching courses
    final response = await Requests.post(url + '/operations', body: {
      "entity": "reservation",
      "operation": "userAdd",
      "idInsegnamento": idInsegnamento,
    });

    dynamic data = response.json();
    if (data['status'] == 'ok') {
      return true;
    } else {
      return false;
    }
  } 
}

class TeachingsByProf {
  String nomeDocente;
  String cognomeDocente;
  List<Teaching> teachings;

  TeachingsByProf(this.nomeDocente, this.cognomeDocente, this.teachings);

  static Future<List<TeachingsByProf>> fetchTeaching(int idCorso) async {
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';
    List<TeachingsByProf> teachings = [];

    //fetching courses
    final response = await Requests.get(url +
        '/getData?operation=getTeachingByCourse&&id=' +
        idCorso.toString());

    //TODO:check response status
    dynamic data = response.json();
    //print(data);
    for (int i = 0; i < data.length; i++) {
      String nomeDocente = data[i]['docente']['nome'];
      String cognomeDocente = data[i]['docente']['cognome'];

      List<Teaching> thisteachings = [];
      for (int j = 0; j < data[i]['insegnamenti'].length; j++) {
        int id = data[i]['insegnamenti'][j]['id'];
        int giorno = data[i]['insegnamenti'][j]['giorno'];
        double ora = data[i]['insegnamenti'][j]['ora'];
        bool isAttivo = data[i]['insegnamenti'][j]['isAttivo'];
        thisteachings.add(Teaching(id: id, giorno: getDayByNumber(giorno), ora: ora, isAttivo: isAttivo));
      }
      teachings.add(TeachingsByProf(nomeDocente, cognomeDocente, thisteachings));
    }
    print (teachings);
    return teachings;
  }

  

  static String getDayByNumber(int day) {
    switch (day) {
      case 1:
        return "Lunedi";
      case 2:
        return "Martedi";
      case 3:
        return "Mercoledi";
      case 4:
        return "Giovedi";
      case 5:
        return "Venerdi";
      default:
        return "";
    }
  }
}
