import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestion_emploi_temps/view/controllersView/searchclasseview.dart';

import '../pageAcceuil_Admin/home.dart';
import '../pageSecondaire/crud/ajouterclasse.dart';

class LesClasseView extends StatefulWidget {
  const LesClasseView({super.key});

  @override
  State<LesClasseView> createState() => _LesClasseViewState();
}

class _LesClasseViewState extends State<LesClasseView> {
 final TextEditingController nomController=TextEditingController();
 final TextEditingController deleteController=TextEditingController();
  final TextEditingController rechercheController=TextEditingController();
  final CollectionReference classes = 
  FirebaseFirestore.instance.collection('classes');

  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.5),
        appBar: AppBar(
          title:const Text(
            'CLASSES',
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
              MaterialPageRoute(builder:(context)=> HomePageAdmin()),);
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'recherche',
                                      style:TextStyle(
                                        color:Colors.blue,
                                      )
                                    ),
                                    content:TextFormField(
                                      controller: rechercheController,
                                      decoration: InputDecoration(hintText: "Entrez le nom  de la classe"),
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
                                          MaterialPageRoute(builder:(context)=> SearchClasseView(
                                            search:rechercheController.text.trim())
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
                const SizedBox(height: 35,),
                Expanded(
                  child: StreamBuilder(
                    stream: classes.snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
                      if(streamSnapshot.hasData){
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: (){},
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
                                      child: Image.asset('assets/salle.jfif',height: 75,),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(documentSnapshot['libelleclasse'],
                                          style: TextStyle(
                                            color: Colors.red,
                                                fontFamily: 'serif',
                                                fontSize: 20,
                                          ),
                                          
                                          ),
                                          SizedBox(height: 5,),
                                          Text('Nombre d\'etudiant:${documentSnapshot['nbreEtudiant']}',
                                          style: Theme.of(context).textTheme.bodySmall,),
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
                                  MaterialPageRoute(builder:(context)=> AjouterClasse()),
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
                                          controller: nomController,
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
                                            isEqualTo: deleteController.text.trim()
                                          )
                                          .get().then((querySnapshot) {
                                            querySnapshot.docs.forEach((doc) {
                                              FirebaseFirestore.instance.collection('classes').doc(doc.id).delete();
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