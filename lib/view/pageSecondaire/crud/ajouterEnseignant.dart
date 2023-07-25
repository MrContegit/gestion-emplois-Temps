
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/controllers/enseignant.dart';
import 'package:gestion_emploi_temps/view/controllersView/enseignantView.dart';
import '../../widgets/text.form.global.dart';
import 'package:image_picker/image_picker.dart';

class AjouterEnseignant extends StatefulWidget {
  const AjouterEnseignant({super.key});

  @override
  State<AjouterEnseignant> createState() => _AjouterEnseignantState();
}

class _AjouterEnseignantState extends State<AjouterEnseignant> {


  final TextEditingController nomController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController telController=TextEditingController();
  final TextEditingController matiereController=TextEditingController();
  final TextEditingController deleteController=TextEditingController();
  FirebaseStorage _storage = FirebaseStorage.instance;
  late Enseignant es;
  late String imgUrl='';

  Future signIn({required Enseignant es}) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const Center(child: CircularProgressIndicator(),)
    );
    final docUser=FirebaseFirestore.instance.collection('enseignant').doc();
    final json={
      'codeEns':docUser.id,
      'nom':es.nom,
      'email':es.email,
      'password':es.password,
      'idMat':es.idMat,
      'numeroTel':es.numeroTel,
    };
    await docUser.set(json);
    final imaDoc = await FirebaseStorage.instance.ref('${json['codeEns']}.jpg');
    await imaDoc.putFile(Imagefile);
    imgUrl = await imaDoc.getDownloadURL();
     
    setState(() {
      imgUrl;
    });
  }

  File Imagefile=File('assets/ajouter.png');
  void getImage({required ImageSource source})async{
    final file = await ImagePicker().pickImage(source: source);
    if(file?.path != null){
      setState(() {
        Imagefile = File(file!.path);
        
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.5),
      appBar: AppBar(
          title:const Text(
            'AJOUTER ENSEIGNANT',
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
                MaterialPageRoute(builder:(context)=>const EnseignantView()));
              }),
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
              const SizedBox(height: 30),
              if(Imagefile!=null && imgUrl!='')
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.fromLTRB(90, 20, 20, 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    image: DecorationImage(
                      image:FileImage(Imagefile),
                      fit: BoxFit.cover
                    )
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.fromLTRB(75,0,20,0),
                  child:Icon(
                        Icons.image,
                        size: 200,
                        color: Colors.red.withOpacity(0.7),
                  ),
                ),
              const SizedBox(height: 10),
              ///Nom
              Container(
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: TextFormGlobal(
                    controller: nomController,
                    text: 'Nom',
                    textInputType:TextInputType.name,
                    obscure: false,
                  ),
                
              ),
              const SizedBox(height: 20),
              //photo
              ElevatedButton(
                      onPressed:()=>getImage(source: ImageSource.gallery) ,
                      child: Container(
                        alignment:Alignment.center,
                        height:49,
                        width: 330,
                        decoration: BoxDecoration(
                          color:Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color:Colors.blue.withOpacity(0.3),
                              blurRadius: 10,
                            )
                          ]
                        ),
                        child:Row(
                          children: [
                            Text(
                              'Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                
                              ),
                            ),
                            IconButton(
                              onPressed:(){}, 
                              icon: const Icon(Icons.image))
                          ],
                        ),
                      )
                    ),
              const SizedBox(height: 20),
              //email
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child:TextFormGlobal(
                controller: emailController,
                text: 'email',
                textInputType:TextInputType.emailAddress,
                obscure: false,
                ),
              ),
              const SizedBox(height: 20),
              //telephone
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child:TextFormGlobal(
                    controller: telController,
                    text: 'numeroTel',
                    textInputType:TextInputType.phone,
                    obscure: false,
                ),
              ),
              const SizedBox(height: 20),
              //Matiere
              Container(
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                    padding: EdgeInsets.fromLTRB(20,0,20,0),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                        )
                      ]
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20,0,0,0),
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: liste,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            selection=value.toString();
                        }),
                        selectedItem:'Matiere',
                      ),
                    )
                  ),
              ),
              const SizedBox(height: 20),
              //password
              Container (
                padding: EdgeInsets.fromLTRB(20,0,20,0),
                child:TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType:TextInputType.visiblePassword,
                  obscure: true,
                ),
              ),
              const SizedBox(height: 15),
              ///Button
              Container(
                padding: EdgeInsets.fromLTRB(30,0,20,0),
                child: 
                  ElevatedButton(
                    onPressed:(){
                      es=Enseignant(
                        id: '',
                        nom: nomController.text.trim(),
                        email: emailController.text.trim(),
                        idMat:selection,
                        numeroTel: telController.text.trim(),
                        password: passwordController.text.trim()
                      );
                      signIn(es: es);
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
              const SizedBox(height: 10),
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
          )
        ),
      ) 
    );
  }
}
final listmat = FirebaseFirestore.instance.collection("matiere");
List<String> ListeMatiere(){
      List<String> listematiere=[];
      listmat.get().then(
        (query) {
          print("Successfully completed");
          for (var docSnapshot in query.docs) {
          listematiere.add(docSnapshot.data()['libelle']) ;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      
      return listematiere;
    }
  

String selection="matiere";
List<String> liste=[
  "Analyse",
  "Algebre",
  "Mecanique solide",
  "chimie general"
];