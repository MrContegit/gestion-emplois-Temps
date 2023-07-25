import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gestion_emploi_temps/controllers/enseignant.dart';
import 'package:gestion_emploi_temps/view/controllersView/searchEnseignantView.dart';
import '../pageAcceuil_Admin/home.dart';
import '../pageSecondaire/crud/afficherEnseignant.dart';
import '../pageSecondaire/crud/ajouterEnseignant.dart';


class EnseignantView extends StatefulWidget {
  const EnseignantView({super.key});

  @override
  State<EnseignantView> createState() => _EnseignantViewState();
}

class _EnseignantViewState extends State<EnseignantView> {
  final CollectionReference enseignant = FirebaseFirestore.instance.collection('enseignant');
  final TextEditingController rechercheController=TextEditingController();
  final TextEditingController deleteController=TextEditingController();
  late String url='';
  @override

  Future<String> Imgurl(String nom)async{
      final doc= await FirebaseStorage.instance.ref('${nom}.jpg');
      await doc.getDownloadURL().then((value){url=value;});
      setState(() {
        
      });
      return doc.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.5),
        appBar: AppBar(
          title:const Text(
            'ENSEIGNANT',
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
                MaterialPageRoute(builder:(context)=>const HomePageAdmin()));
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'recherche',
                        style:TextStyle(
                          color:Colors.blue,
                        )
                      ),
                      content:TextFormField(
                        controller: rechercheController,
                        decoration: InputDecoration(hintText: "Entrez le nom  de l'enseignant"),
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
                            Navigator.push(context,
                            MaterialPageRoute(builder:(context)=> SearchEnseignantView(
                              search:rechercheController.text.trim().toLowerCase())
                            ),
                            );
                          },
                        ),
                      ],
                    );
                  });
                },
            )
          ],
        ),
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
                  child: StreamBuilder(
                    stream: enseignant.snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
                      if(streamSnapshot.hasData){
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder:(context)=> AfficherEnseignant(id:documentSnapshot['codeEns'],))
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                     // child: Image(
                                        //image: NetworkImage(Imgurl('${documentSnapshot['codeEns']}.jpg'))
                                     // ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(documentSnapshot['nom'],
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'serif',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            'Tel:${documentSnapshot['numeroTel']}',
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          SizedBox(height: 5,),
                                          Text('Matiere:${documentSnapshot['idMat']}',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontFamily: 'serif',
                                            fontSize: 15,
                                          ),
                                          ),
                                          const SizedBox(height: 5,),
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context,_){
                            return const SizedBox(height: 10,);
                          }, 
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  )         
                )
                ,const SizedBox(height: 25,),
                IntrinsicHeight(
                  child: Stack(
                    alignment:Alignment.center ,
                    children: [
                      Row(
                          children: [
                            Ink(
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
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                child: const Center(
                                  child: Icon(Icons.add,
                                  color: Colors.white,),
                                ),
                                onTap:(){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder:(context)=> const AjouterEnseignant()),
                                    );
                                  },
                              ),
                              ),
                            SizedBox(width: 20,),
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
                                          controller: deleteController,
                                          decoration: InputDecoration(hintText: "Entrez le nom  de l'enseignant a supprimer"),
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
                                          FirebaseFirestore.instance.collection('enseignant').where(
                                            'nom',
                                            isEqualTo: deleteController.text.trim()
                                          )
                                          .get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              FirebaseFirestore.instance.collection('enseignant').doc(doc.id).delete();
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
          ),
        ),
      ),
    );
  }
}