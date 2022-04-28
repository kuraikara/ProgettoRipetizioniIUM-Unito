import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'course.dart';

class Reservation {
  final int id;
  final String corso;
  final String nomeDocente;
  final String cognomeDocente;
  final String giorno;
  final double ora;
  final String stato;

  Reservation(
      {required this.id,
      required this.corso,
      required this.nomeDocente,
      required this.cognomeDocente,
      required this.giorno,
      required this.ora,
      required this.stato});

  static Future<bool> update(int idPrenotazione, String stato) async {
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';

    print(idPrenotazione.toString() + ' ' + stato);
    //fetching courses
    final response = await Requests.post(url + '/operations', body: {
      "entity": "reservation",
      "operation": "userUpdate",
      "idPrenotazione": idPrenotazione.toString(),
      "stato": stato,
    });

    dynamic data = response.json();
    print(data);
    if (data['status'] == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Reservation>> fetchReservation() async {
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';
    List<Reservation> reservations = [];

    //fetching courses
    final response =
        await Requests.get(url + '/getData?operation=getMyReservations');

    //TODO:check response status
    dynamic data = response.json();
    print(data);

    for (int i = 0; i < data.length; i++) {
      String nomeDocente = data[i]['insegnamento']['docente']['nome'];
      String cognomeDocente = data[i]['insegnamento']['docente']['cognome'];
      Course corso = Course(data[i]['insegnamento']['corso']['id'],
          data[i]['insegnamento']['corso']['nome']);
      String giorno = getDayByNumber(data[i]['insegnamento']['giorno']);
      double oraInizio = data[i]['insegnamento']['ora'];
      String stato = data[i]['stato'];

      reservations.add(Reservation(
        id: data[i]['id'],
        corso: corso.nome,
        nomeDocente: nomeDocente,
        cognomeDocente: cognomeDocente,
        giorno: giorno,
        ora: oraInizio,
        stato: stato,
      ));
    }

    return reservations;
  }

  static Future<String> fetchNotifiche() async {
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';
    String notifiche = "";

    //fetching courses
    final response =
        await Requests.get(url + '/getData?operation=getMyNotifications');

    //TODO:check response status
    dynamic data = response.json();
    print(data);

    for (int i = 0; i < data.length; i++) {
      String raw;
      if (data[i]['stato'] == 'A') {
        raw = i.toString() +
            "-È stata attivata una ripetizione per " +
            data[i]['insegnamento']['corso']['nome'] +
            " con il docente " +
            data[i]['insegnamento']['docente']['nome'] +
            ' ' +
            data[i]['insegnamento']['docente']['cognome'] +
            " per il giorno " +
            getDayByNumber(data[i]['insegnamento']['giorno']) +
            " alle ore " +
            data[i]['insegnamento']['ora'].toString();
      } else {
        raw = i.toString() +
            "-La ripetizione per " +
            data[i]['insegnamento']['corso']['nome'] +
            " con il docente " +
            data[i]['insegnamento']['docente']['nome'] +
            ' ' +
            data[i]['insegnamento']['docente']['cognome'] +
            " per il giorno " +
            getDayByNumber(data[i]['insegnamento']['giorno']) +
            " alle ore " +
            data[i]['insegnamento']['ora'].toString() +
            " è stata marcata come ";
        data[i]['stato'] == 'D' ? raw += "disdetta" : raw += "eseguita";
      }
      notifiche += raw + "\n\n";
    }

    return notifiche;
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
