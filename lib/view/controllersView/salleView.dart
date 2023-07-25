import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gestion_emploi_temps/view/controllersView/searchsalleview.dart';
import '../pageAcceuil_Admin/home.dart';
import '../pageSecondaire/ajouterSalle.dart';



class SalleView extends StatefulWidget {
  const SalleView({super.key});

  @override
  State<SalleView> createState() => _SalleViewState();
}

class _SalleViewState extends State<SalleView> {
  final TextEditingController nomController=TextEditingController();
  final TextEditingController rechercheController=TextEditingController();
  final CollectionReference enseignant = 
  FirebaseFirestore.instance.collection('salles');

  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.5),
        appBar: AppBar(
          title:const Text(
            'SALLES',
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
                                          Text(documentSnapshot['libelle'],
                                            style: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'serif',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            'Periode libre d\'utilisation: ${documentSnapshot['periodeUtil']} heure',
                                            style: Theme.of(context).textTheme.bodySmall,  
                                          ),
                                          SizedBox(height: 10,),
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
                                  MaterialPageRoute(builder:(context)=> AjouterSalle()),
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
          ),
        ),
      ),
    );
  }
}