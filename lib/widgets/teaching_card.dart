import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/model/teaching.dart';

class TeachingCard extends StatelessWidget {
  final String nomeDocente;
  final String cognomeDocente;
  final VoidCallback aggiornaInsegnamenti;

  final List<Teaching> teachings;

  TeachingCard(
      {required this.aggiornaInsegnamenti,
      required this.teachings,
      required this.nomeDocente,
      required this.cognomeDocente});

  List<Widget> takeTeachingRows(BuildContext context) {
    List<Widget> widgets = [];
    teachings.forEach((element) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Text(
                element.giorno + " ore " + element.ora.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: element.isAttivo == false
                  ? Text("Sei già prenotato \n per questi giorno e ora",
                      textAlign: TextAlign.center)
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Conferma prenotazione"),
                            content: Text("Sei sicuro di voler prenotare per " +
                                element.giorno +
                                " ore " +
                                element.ora.toString()),
                            actions: <Widget>[
                              TextButton(
                                child: Text("No"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text("Conferma"),
                                onPressed: () {
                                  prenota(element.id).then((value){
                                    if (value == true){
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Prenotazione effettuata"),
                                        content: Text(
                                            "Prenotazione effettuata con successo"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                    aggiornaInsegnamenti();
                                  } else {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Errore"),
                                        content:
                                            Text("Errore nella prenotazione"),
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
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "Prenota",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
            ),
          ],
        ),
      ));
    });

    return widgets;
  }

  Future<bool> prenota(int id) async {
    if (await Teaching.prenota(id)) {
      aggiornaInsegnamenti();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  child: Text(
                    "Prof. " + nomeDocente + " " + cognomeDocente,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: takeTeachingRows(context),
                ),
              ),
            ],
          ),
        ));
  }
}
