import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestion_emploi_temps/view/controllersView/enseignantView.dart';

import '../pageAcceuil_Admin/home.dart';
import '../pageSecondaire/crud/afficherEnseignant.dart';
import '../pageSecondaire/crud/ajouterEnseignant.dart';

class SearchEnseignantView extends StatefulWidget {
  const SearchEnseignantView({super.key,required this.search});
  final String search;
  @override
  State<SearchEnseignantView> createState() => _SearchEnseignantViewState();
}

class _SearchEnseignantViewState extends State<SearchEnseignantView> {
  late  dynamic enseignant;
  @override
  void initState() {
    super.initState(); 
    getCours(); 
  }
  Future<Query<Map<String, dynamic>>> getCours() async{
  enseignant = FirebaseFirestore.instance.collection('enseignant')
  .where('nom',isEqualTo: widget.search );
    return enseignant;
  }
  final TextEditingController rechercheController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
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
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      const Align(
                        child: Text(
                          'ENSEIGNANT',
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
                                MaterialPageRoute(builder:(context)=> EnseignantView()),);
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
                            child: Center(
                              child: const Icon(Icons.add),
                            ),
                            onTap:(){
                                Navigator.push(context,
                                  MaterialPageRoute(builder:(context)=> AjouterEnseignant()),
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
                        right: 50,
                        child:Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: const Icon(Icons.search),
                            ),
                            onTap:(){
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
                                spreadRadius:.05,
                              )
                            ]
                          ),
                        )
                      )
                    ],
                  ),
                ),
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
                                      child: Image.asset('assets/salle.jfif',height: 75,),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(documentSnapshot['nom']),
                                          Text(
                                            '${documentSnapshot['numeroTel']}',
                                            //style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          Text('${documentSnapshot['idMat']}'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}