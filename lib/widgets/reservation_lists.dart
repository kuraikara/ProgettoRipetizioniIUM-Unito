import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/model/reservation.dart';
import 'package:ripetizioni_mobile_app/pages/reservationpage.dart';

class ReservationsAttiveList extends StatelessWidget {
  final List<Reservation> reservations;
  final VoidCallback reflesh;

  ReservationsAttiveList({required this.reservations, required this.reflesh});

  @override
  Widget build(BuildContext context) {
    return reservations.isEmpty
        ? ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(top: 150),
              child: Text('Nessuna prenotazione attiva',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            ),
          )
        : AnimatedList(
            initialItemCount: reservations.length,
            itemBuilder: (context, index, animation) =>
                (reservations.asMap().containsKey(index)
                    ? SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.blue[50],
                          child: ListTile(
                            title: Text(
                              reservations[index].corso,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              'Docente: ' +
                                  reservations[index].nomeDocente +
                                  ' ' +
                                  reservations[index].cognomeDocente +
                                  '\n' +
                                  'Giorno: ' +
                                  reservations[index].giorno +
                                  '\n' +
                                  'Ora: ' +
                                  reservations[index].ora.toString(),
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: IconButton(
                                      icon: Icon(Icons.check_circle_rounded,
                                          size: 50, color: Colors.green),
                                      onPressed: () {
                                        Reservation.update(
                                                reservations[index].id, 'E')
                                            .then((value) {
                                          if (value == true) {
                                            showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Successo"),
                                        content: Text(
                                            "Operazione effettuata con successo"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                          }else{
                                            showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Errore"),
                                        content: Text(
                                            "C'è stato un errore nell'eseguire l'operazione"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                          }
                                          reflesh();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: IconButton(
                                      icon: Icon(Icons.delete_rounded,
                                          size: 50, color: Colors.red),
                                      onPressed: () {
                                        Reservation.update(
                                                reservations[index].id, 'D')
                                            .then((value) {
                                          if (value == true) {
                                            showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Successo"),
                                        content: Text(
                                            "Operazione effettuata con successo"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                          }else{
                                            showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Errore"),
                                        content: Text(
                                            "C'è stato un errore nell'eseguire l'operazione"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                          }
                                          reflesh();
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    : Text("")));
  }
}

class ReservationsPassateList extends StatelessWidget {
  final List<Reservation> reservations;
  final VoidCallback reflesh;

  ReservationsPassateList({required this.reservations, required this.reflesh});

  @override
  Widget build(BuildContext context) {
    return reservations.isEmpty
        ? ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(top: 150),
              child: Text('Nessuna prenotazione passata',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            ),
          )
        : AnimatedList(
            initialItemCount: reservations.length,
            itemBuilder: (context, index, animation) =>
                (reservations.asMap().containsKey(index)
                    ? SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.blue[50],
                          child: ListTile(
                            title: Text(
                              reservations[index].corso,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                                'Docente: ' +
                                    reservations[index].nomeDocente +
                                    ' ' +
                                    reservations[index].cognomeDocente +
                                    '\n' +
                                    'Giorno: ' +
                                    reservations[index].giorno +
                                    '\n' +
                                    'Ora: ' +
                                    reservations[index].ora.toString(),
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis),
                            trailing: Container(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                    reservations[index].stato == 'E'
                                        ? "Eseguita"
                                        : "Disdetta",
                                    style: TextStyle(fontSize: 24))),
                          ),
                        ),
                      )
                    : Text("")),
          );
  }
}
