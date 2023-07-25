import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/controllers/enseignant.dart';
import 'package:gestion_emploi_temps/view/controllersView/enseignantView.dart';
import '../../controllers/salle.dart';
import '../controllersView/salleView.dart';
import '../widgets/text.form.global.dart';

class AjouterSalle extends StatefulWidget {
  const AjouterSalle({super.key});

  @override
  State<AjouterSalle> createState() => _AjouterSalleState();
}

class _AjouterSalleState extends State<AjouterSalle> {

  final docUser=FirebaseFirestore.instance.collection('salles').doc();
  final TextEditingController nomController=TextEditingController();
  final TextEditingController nbreplaceController=TextEditingController();
  final TextEditingController periodeController=TextEditingController();
  
  
  late Salle salle;

  Future InSalle({required Salle salle}) async{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
      final json={
        'idsalle':docUser.id,
        'libelle':salle.libelle,
        'nbreplace':salle.nbreplace,
        'periodeUtil':salle.periodeUtil,
      };
      await docUser.set(json);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Salle enregistrer.',
          style: TextStyle(fontSize: 15,color: Colors.blue),
        )
      ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.5),
    appBar: AppBar(
          title:const Text(
            'AJOUTER UNE SALLE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif'
            )
          ) ,
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder:(context)=>const SalleView()));
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {

               },
            )
          ],
        ),
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
              const SizedBox(height: 50),
               Container(
                padding: EdgeInsets.fromLTRB(75,0,20,0),
                child:Icon(
                        Icons.note_add,
                        size: 200,
                        color: Colors.red.withOpacity(0.7),
                      ),
              ),
              const SizedBox(height:50),
              ///Nom
              Container(
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: TextFormGlobal(
                    controller: nomController,
                    text: 'Nom de la salle',
                    textInputType:TextInputType.name,
                    obscure: false,
                  ),
                
              ),
              const SizedBox(height: 20),
              //Nbre de places
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child:TextFormGlobal(
                controller: nbreplaceController,
                text: 'Nombre de place',
                textInputType:TextInputType.number,
                obscure: false,
                ),
              ),
              const SizedBox(height: 20),
              //periode utilisation
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child:TextFormGlobal(
                    controller: periodeController,
                    text: 'periode d\'utilisation',
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
                            'Salle non enregistrer.',
                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                          )
                        ));
                      }else{
                      salle=Salle(
                        idsalle: '',
                        libelle: nomController.text.trim(),
                        nbreplace:int.parse(nbreplaceController.text.trim()),
                        periodeUtil: int.parse(periodeController.text.trim()),
                      );
                      InSalle(salle: salle);
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
                                          decoration: InputDecoration(hintText: "Entrez le nom  de la salle a supprimer"),
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
                                          FirebaseFirestore.instance.collection('salles').where(
                                            'libelle',
                                            isEqualTo: nomController.text.trim()
                                          )
                                          .get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              FirebaseFirestore.instance.collection('salles').doc(doc.id).delete();
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
  }
}