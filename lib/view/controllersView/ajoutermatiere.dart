import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../controllers/matiere.dart';
import '../pageAcceuil_Admin/home.dart';
import '../widgets/text.form.global.dart';

class AjouterMatiere extends StatefulWidget {
  const AjouterMatiere({super.key});

  @override
  State<AjouterMatiere> createState() => _AjouterMatiereState();
}

class _AjouterMatiereState extends State<AjouterMatiere> {
  final docUser=FirebaseFirestore.instance.collection('matiere').doc();
  final TextEditingController nomController=TextEditingController();
  final TextEditingController nbreplaceController=TextEditingController();
  final TextEditingController periodeController=TextEditingController();
  
  
  late Matiere matiere;

  Future InSalle({required Matiere matiere}) async{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
      final json={
        'idMat':docUser.id,
        'libelle':matiere.libelle,
        'credit':matiere.credit,
        'volumeHoraire':matiere.volumeHoraire,
      };
      await docUser.set(json);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Matiere enregistrer.',
          style: TextStyle(fontSize: 15,color: Colors.blue),
        )
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePageAdmin()),
                (Route<dynamic> route) => false);
          }),
        ),
    backgroundColor: Colors.blue.withOpacity(0.5),
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
              SizedBox(height: 30,),
              IntrinsicHeight(
                    child: Stack(
                      children: [
                        const Align(
                          child: Text(
                            'AJOUTER UNE MATIERE',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                          ),
                        ),
                        
                      ],
                    ),
                  ),
              const SizedBox(height:50),
              //libelle
              Container(
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: TextFormGlobal(
                    controller: nomController,
                    text: 'Nom de la matiere',
                    textInputType:TextInputType.name,
                    obscure: false,
                  ),
                
              ),
              const SizedBox(height: 20),
              //credit
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child:TextFormGlobal(
                controller: nbreplaceController,
                text: 'Nombre de credit',
                textInputType:TextInputType.number,
                obscure: false,
                ),
              ),
              const SizedBox(height: 20),
              //volume Horaire
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child:TextFormGlobal(
                    controller: periodeController,
                    text: 'volume horaire',
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
                      if(nomController.text.trim()=='' || nbreplaceController.text.trim()=='' || periodeController.text.trim()==''){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            'Matiere non enregistrer.',
                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                          )
                        ));
                      }else{
                      matiere=Matiere(
                        libelle: nomController.text.trim(),
                        credit:int.parse(nbreplaceController.text.trim()),
                        volumeHoraire: int.parse(periodeController.text.trim()),
                      );
                      InSalle(matiere: matiere);
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
                          fontFamily: 'serif'
                        ),
                      ),
                    )
                  ),
              ),            
              const SizedBox(height: 50),
              IntrinsicHeight(
                  child: Stack(
                    alignment:Alignment.center ,
                    children: [
                      Row(
                          children: [
                            Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            child:  Center(
                              child: Icon(Icons.delete,
                              color: Colors.white,),
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
                                          controller: nomController,
                                          decoration: InputDecoration(hintText: "Entrez le nom  de la matiere a supprimer"),
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
                                          FirebaseFirestore.instance.collection('matiere').where(
                                            'libelle',
                                            isEqualTo: nomController.text.trim()
                                          )
                                          .get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              FirebaseFirestore.instance.collection('matiere').doc(doc.id).delete();
                                            });
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text(
                                              'suppression effectuer.',
                                              style: TextStyle(fontSize: 15,color: Colors.blue),
                                            )
                                          ));
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                            
                            } ,
                          ),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                      
                          ],
                        )
                    ],
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