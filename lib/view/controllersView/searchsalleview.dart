import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../pageAcceuil_Admin/home.dart';
import '../pageSecondaire/ajouterSalle.dart';

class SearchSalleView extends StatefulWidget {
  const SearchSalleView({super.key,required this.search});
  final String search;

  @override
  State<SearchSalleView> createState() => _SearchSalleViewState();
}

class _SearchSalleViewState extends State<SearchSalleView> {
 final TextEditingController nomController=TextEditingController();
  final TextEditingController rechercheController=TextEditingController();
  late  dynamic enseignant;
  @override
  void initState() {
    super.initState(); 
    getCours(); 
  }
  Future<Query<Map<String, dynamic>>> getCours() async{
  enseignant = FirebaseFirestore.instance.collection('salles')
  .where('libelle',isEqualTo: widget.search );
    return enseignant;
  }
  
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
                          'SALLES',
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
                                MaterialPageRoute(builder:(context)=> HomePageAdmin()),);
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
                              child: const Icon(Icons.add),
                            ),
                            onTap:(){
                                Navigator.push(context,
                                  MaterialPageRoute(builder:(context)=> AjouterSalle()),
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
                        right: 100,
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
                                          MaterialPageRoute(builder:(context)=> SearchSalleView(
                                            search:rechercheController.text.trim())
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
                                          Text(documentSnapshot['libelle']),
                                          Text(
                                            'Periode libre d\'utilisation: ${documentSnapshot['periodeUtil']} heure',
                                            //style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          Text('Nombre de places:${documentSnapshot['nbreplace']}',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}