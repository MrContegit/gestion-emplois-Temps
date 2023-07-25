import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/controllersView/enseignantView.dart';
import '../../../controllers/enseignant.dart';

class AfficherEnseignant extends StatefulWidget {
  const AfficherEnseignant({super.key,required this.id}) ;
  final String id;

  @override
  State<AfficherEnseignant> createState() => _AfficherEnseignantState();
}

class _AfficherEnseignantState extends State<AfficherEnseignant> {
  
      @override
  void initState() {
    getCours(); 
    getEnseigant(); 
    super.initState();
  }
 
  List<Map<String,dynamic>> LT=[];


  Future getCours() async{
    await FirebaseFirestore.instance.collection('LesCours')
    .where('idenseignant',isEqualTo: widget.id)
    .get().then((snapshot) async{
      snapshot.docs.forEach((doc)async {
        Map<String,dynamic> infoCours={
          'matiere':'',
          'classe':'',
          'jour':'',
          'salle':'',
          'Heure':'',
        };
        infoCours['classe']=doc.data()['idClasse'];
        infoCours['salle']=doc.data()['idsalle'];
        infoCours['jour']=doc.data()['idJour'];
        infoCours['matiere']=doc.data()['idMatiere'];
        infoCours['Heure']=doc.data()['heure'];
        LT.add(infoCours);
        });
        setState(() {
          LT;
        });
      });

  }



  Enseignant es=Enseignant(
    id: '', 
    nom: 'bdgbdggdgnndgb', 
    email: '', idMat: '', 
    numeroTel: '', 
    password: ''
  );


  Future<Enseignant> getEnseigant()async{
    final docRef = FirebaseFirestore.instance.collection("enseignant").doc(widget.id);
    es= await docRef.get().then(
      (DocumentSnapshot doc) async {
         return Enseignant.fromJson(doc.data()as Map<String,dynamic>);
      }
    );
    setState(() {
      es;
    });
    return es;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                const SizedBox(height: 35,),
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      const Align(
                        child: Text(
                          'INFO ENSEIGNANT',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child:Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: const Icon(Icons.arrow_back),
                            ),
                            onTap:(){
                                Navigator.push(context,
                                  MaterialPageRoute(builder:(context)=> EnseignantView()),
                                );
                              },
                          ),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 2.0,
                                spreadRadius: .05,
                              )
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45,),
                Row(
                  children: [
                    Container(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.7),
                          blurRadius: 7,
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/photoEns.jfif',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      
                      ),
                    ),
                  ),
                  const SizedBox(width:20,),
                  Column(
                      children:[
                        Text(es.nom),
                        Text(es.email),
                        Text(es.numeroTel),
                        Text(es.idMat),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 35,),
                for( var val in LT)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.asset('assets/salle.jfif',height: 75,),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(val['matiere'],
                              style: TextStyle(
                                color: Colors.blue
                              ),),
                              Text(val['classe'],
                              style: TextStyle(
                                color: Colors.blue
                              ),),
                              Text(val['salle'],
                              style: TextStyle(
                                color: Colors.blue
                              ),),
                              Text(val['jour'],
                                style: TextStyle(
                                  color: Colors.blue
                              ),),
                              const SizedBox(height:25,),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
