import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AfficherCours extends StatefulWidget {
  const AfficherCours({required this.map,super.key, this.numSem});
  final Map<String,String> map;
  final String? numSem;
  @override
  State<AfficherCours> createState() => _AfficherCoursState();
}

class _AfficherCoursState extends State<AfficherCours> {
  final  cours = FirebaseFirestore.instance.collection('LesCours');
  final TextEditingController rechercheController=TextEditingController();
  final TextEditingController deleteController=TextEditingController();
  List<Map<String,String>> listeCour= [];

  @override
  void initState() {
    super.initState();
    getCours();
  }
  @override
  void dispose() {
    super.dispose();
  }
   Future getCours()async{
    List<Map<String,String>> listeCours = [];
  
    await cours.where('idClasse',isEqualTo: widget.map['classe'])
      .where('idJour',isEqualTo: widget.numSem)
      .get().then((value){
        for (var element in value.docs) {
          Map<String,String> details={
            'heure':'', 
            'enseignant':'',
            'salle':'',
            'matiere':''
          };
          {details['heure'] = element.data()['heure'].toString();
          details['enseignant'] = element.data()['idenseignant'].toString();
          details['salle'] = element.data()['idsalle'].toString();
          details['matiere'] = element.data()['idMatiere'].toString();}
          listeCours.add(details);
          //print('*******************${listeCours.toString()}**********************************');
        }
        setState(() {
          listeCour=listeCours;
        });
      });
      
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.7),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for( var val in listeCour)
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin:const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.asset('assets/salle.jfif',height: 75,),
                          ),
                          const SizedBox(width: 30,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(val['enseignant']!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'serif',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                  
                                ),),
                                SizedBox(height: 5,),
                                Text('Matiere:${val['matiere']!}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'serif',
                                  fontSize: 15,
                                ),),
                                SizedBox(height: 5,),
                                Text('Salle : ${val['salle']!}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'serif',
                                  fontSize: 15,
                                ),),
                                SizedBox(height: 5,),
                                Text('Heure : ${val['heure']!}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'serif',
                                    fontSize: 15,
                                ),),
                                const SizedBox(height:25,),
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                      ],
                    ),
                  )         
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}