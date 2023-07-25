import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestion_emploi_temps/controllers/lesclasse.dart';

import '../../../controllers/salle.dart';
import '../../controllersView/lesClassesView.dart';
import '../../controllersView/salleView.dart';
import '../../widgets/text.form.global.dart';

class AjouterClasse extends StatefulWidget {
  const AjouterClasse({super.key});

  @override
  State<AjouterClasse> createState() => _AjouterClasseState();
}

class _AjouterClasseState extends State<AjouterClasse> {
  final docUser=FirebaseFirestore.instance.collection('classes').doc();
  final TextEditingController libelleController=TextEditingController();
  final TextEditingController searchController=TextEditingController();
  final TextEditingController nbreEtudiantController=TextEditingController();
  
  
  late LesClasses lesclasse;

  Future InClasse({required LesClasses lesclasse}) async{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
      final json={
        'idclasse':docUser.id,
        'libelleclasse':lesclasse.libelleclasse,
        'nbreEtudiant':lesclasse.nbreEtudiant,
      };
      await docUser.set(json);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Classe enregistrer.',
          style: TextStyle(fontSize: 15,color: Colors.blue),
        )
      ));

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
                          'AJOUTER UNE CLASSE',
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
                            child:  Center(
                              child: Icon(Icons.arrow_back),
                            ),
                            onTap:(){
                                Navigator.push(context,
                                MaterialPageRoute(builder:(context)=>const LesClasseView())
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
                      Positioned(
                        right: 0,
                        child:Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            child:  Center(
                              child: Icon(Icons.delete),
                            ),
                            onTap:(){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Supprimer',
                                    style:TextStyle(
                                      color:Colors.blue,
                                    ) ),
                                    content:TextFormField(
                                          controller: searchController,
                                          decoration: InputDecoration(hintText: "Entrez le nom  de la classe a supprimer"),
                                        ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('CANCEL'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('valider'),
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection('classes').where(
                                            'libelleclasse',
                                            isEqualTo: searchController.text.trim()
                                          )
                                          .get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              FirebaseFirestore.instance.collection('classes').doc(doc.id).delete();
                                            });
                                          });
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text(
                                              'suppression effectuer.',
                                              style: TextStyle(fontSize: 15,color: Colors.blue),
                                            )
                                          ));
                                        },
                                      ),
                                    ],
                                  );
                                });
                            } ,
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
              const SizedBox(height: 30),
               Container(
                padding: EdgeInsets.fromLTRB(75,0,20,0),
                child:Icon(
                        Icons.note_add,
                        size: 200,
                        color: Colors.blueGrey,
                      ),
              ),
              const SizedBox(height: 10),
              ///Nom
              Container(
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: TextFormGlobal(
                    controller: libelleController,
                    text: 'Nom de la classe',
                    textInputType:TextInputType.name,
                    obscure: false,
                  ),
                
              ),
              const SizedBox(height: 20),
              //Nbre d'Etudiant
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child:TextFormGlobal(
                controller: nbreEtudiantController,
                text: 'Nombre d\'Etudiant',
                textInputType:TextInputType.number,
                obscure: false,
                ),
              ),
              const SizedBox(height: 20),
              ///Button
              Container(
                padding: EdgeInsets.fromLTRB(30,0,20,0),
                child: 
                  ElevatedButton(
                    onPressed:(){
                      if(libelleController.text.trim()=='' || nbreEtudiantController.text.trim()==''){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            'Classe non enregistrer.',
                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                          )
                        ));
                      }else{
                      lesclasse=LesClasses(
                        idclasse: '',
                        libelleclasse: libelleController.text.trim(),
                        nbreEtudiant:int.parse(nbreEtudiantController.text.trim()),
                      );
                      InClasse(lesclasse: lesclasse);
                      }
                    } ,
                    child: Container(
                      alignment:Alignment.center,
                      height:50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.blue.withOpacity(0.3),
                            blurRadius: 10,
                          )
                        ]
                      ),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ),
              ),            
            ],
              ),
          )
        ),
      ) 
    );
  //mama suzanne collie pour gmere
  }
}