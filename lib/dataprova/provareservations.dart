import 'package:ripetizioni_mobile_app/model/reservation.dart';

final List<Reservation> reservationListAttive = [
  Reservation(
    id: 0,
    corso: 'Matematica',
    nomeDocente: 'Giovanni',
    cognomeDocente: 'Rossi',
    giorno: 'Martedì',
    ora: 9.0,
    stato: 'A',
    ),
  Reservation(
    id: 1,
    corso: 'Fisica',
    nomeDocente: 'Giovanni',
    cognomeDocente: 'Rossi',
    giorno: 'Martedì',
    ora: 10.0,
    stato: 'A',
    ),
];

final List<Reservation> reservationListPassate = [
  Reservation(
    id: 2,
    corso: 'Matematica',
    nomeDocente: 'Marco',
    cognomeDocente: 'Rossi',
    giorno: 'Martedì',
    ora: 9.0,
    stato: 'E',
    ),
  Reservation(
    id: 3,
    corso: 'Fisica',
    nomeDocente: 'Marco',
    cognomeDocente: 'Rossi',
    giorno: 'Martedì',
    ora: 10.0,
    stato: 'D',
    ),
];