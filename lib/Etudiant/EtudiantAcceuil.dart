import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/connection_inscription/signin.dart';

import 'choix.dart';

class EtudiantAcceuil extends StatefulWidget {
  EtudiantAcceuil({super.key});


  @override
  _EtudiantAcceuilState createState() => _EtudiantAcceuilState();
}

class _EtudiantAcceuilState extends State<EtudiantAcceuil> {
  int selectedCandidateIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {       
              }),
          actions: [
            IconButton(
              icon: Icon(Icons.bar_chart),
              onPressed: () {
                //voir les resultats des votes
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.how_to_vote_sharp),
          onPressed: () {
            //voter
          },
        ),
        body:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 90,),
              Container(
                child: Text(
                  "Bienvenue Cher Etudiant!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Expanded(
                child: CustomCarouselFB2(),
              ),
            ],
          ),
        );
  }
}
