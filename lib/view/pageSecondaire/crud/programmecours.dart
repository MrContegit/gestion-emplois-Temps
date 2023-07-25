import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/pageAcceuil_Admin/home.dart';
import 'package:intl/intl.dart';



class ProgrammeCours extends StatefulWidget {
  const ProgrammeCours({super.key});

  @override
  State<ProgrammeCours> createState() => _ProgrammeCoursState();
}

class _ProgrammeCoursState extends State<ProgrammeCours> {

  final listens = FirebaseFirestore.instance.collection("enseignant");
  final listmat = FirebaseFirestore.instance.collection("matiere");
  final listsal = FirebaseFirestore.instance.collection("salles");
  final listcla = FirebaseFirestore.instance.collection("classes");
  final docUser=FirebaseFirestore.instance.collection('cours').doc();
  final docLesCours=FirebaseFirestore.instance.collection('LesCours').doc();
   late String selectedyear='annee';
   late String selectedmonth='mois';
   late String selectedday='jour';
   var formateur = DateFormat('EEEE');
   late String jour_semaine = '';
   late TimeOfDay _time=TimeOfDay.now();

      Future datecours() async {
        final date =await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate:DateTime.now(),
          lastDate: DateTime(2100));
          if (date != null) {
            setState(() {
              selectedyear = date.year.toString();
              selectedmonth = date.month.toString();
              selectedday = date.day.toString();
              jour_semaine = formateur.format(date);
            });
          }
      }
      Future Timecours() async {
        final time =await showTimePicker(
          context: context,
           initialTime: TimeOfDay.now(),
        );
          if (time != null) {
            setState(() {
              _time = time;
            });
          }
      }

    Future InCours() async{
      BDCours['idJour'] = '${selectedday}/${selectedmonth}/${selectedyear}';

      //enseignant
      await FirebaseFirestore.instance.collection('enseignant')
      .where('nom',isEqualTo: BDCours['idenseigant'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            json['idenseignant']=doc.data()['codeEns'].toString();
          });
      });

      //matiere
      await FirebaseFirestore.instance.collection('matiere')
      .where('libelle',isEqualTo: BDCours['idMatiere'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            json['idMatiere']=doc.data()['idMat'].toString();
          });
      });

      //salles
      await FirebaseFirestore.instance.collection('salles')
      .where('libelle',isEqualTo: BDCours['idsalle'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            json['idsalle']=doc.data()['idsalle'].toString();
          });
      });

      //classes
      await FirebaseFirestore.instance.collection('classes')
      .where('libelleclasse',isEqualTo: BDCours['idClasse'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            json['idClasse']=doc.data()['idclasse'].toString();
          });
      });

      //semestre
      await FirebaseFirestore.instance.collection('semestre')
      .where('libelle_semestre',isEqualTo: BDCours['idSemestre'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            json['idSemestre']=doc.data()['codesemestre'].toString();
          });
      });
      
      //jour
      await FirebaseFirestore.instance.collection('jour')
      .where('datejour',isEqualTo: BDCours['idJour'])
      .get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) async {
            if(doc.data().isEmpty==false){
              json['idJour'] = doc.data()['idjour'].toString();
            }
          });
      });
      if(json['idJour'] =='salle.nbreplace'){
        final Enrjour= await FirebaseFirestore.instance.collection('jour').doc();
                await Enrjour.set({
                  'idjour':Enrjour.id,
                  'datejour':BDCours['idJour'],
                  'jour_semaine' :jour_semaine,
                  'statut':false
                });
                json['idJour']=Enrjour.id;
      }
      json['idcours']=docUser.id;
      json['dure']=BDCours['dure']!;
      json['heure'] = _time.hour.toString()+':'+_time.minute.toString();
      BDCours['heure'] = _time.hour.toString()+':'+_time.minute.toString();
      BDCours['id'] = docLesCours.id;
      BDCours['idcours']=docUser.id;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
      await docUser.set(json);
      await docLesCours.set(BDCours);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'cours enregistrer.',
          style: TextStyle(fontSize: 15,color: Colors.blue),
        )
      ));
    }



  Map<String,String>  BDCours={
    'id' : '',
        'heure':'',
        'idcours':'',
        'dure':'',
        'idenseignant':'',
        'idsalle':'docUser.id',
        'idClasse':'salle.libelle',
        'idJour':'salle.nbreplace',
        'idMatiere':'salle.periodeUtil',
        'idSemestre':'salle.periodeUtil',
      };
  final Map<String,String> json={
        'heure':'',
        'idcours':'',
        'dure':'',
        'idenseignant':'',
        'idsalle':'docUser.id',
        'idClasse':'salle.libelle',
        'idJour':'salle.nbreplace',
        'idMatiere':'salle.periodeUtil',
        'idSemestre':'salle.periodeUtil',
      };

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.1),
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
    body: SingleChildScrollView(

      child:SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 15,20,0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  IntrinsicHeight(
                    child: Stack(
                      children: [
                        const Align(
                          child: Text(
                            'AJOUTER UN COURS',
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
                  const SizedBox(height: 30),
                  ///enseignant
                  Container(
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
                        items: ListeEnseignant(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours['idenseignant']=value.toString();
                        }),
                        selectedItem: "enseignant",
                      ),
                    )
                  ),
                  const SizedBox(height: 20),

                  ///jour
                  ElevatedButton(
                    onPressed:(){ 
                      datecours();
                    } ,
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
                            '${selectedyear}-${selectedmonth}-${selectedday}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              
                            ),
                          ),
                          IconButton(
                            onPressed:(){}, 
                            icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  //time
                  ElevatedButton(
                    onPressed:(){ 
                      Timecours();
                    } ,
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
                            _time.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              
                            ),
                          ),
                          IconButton(
                            onPressed:(){}, 
                            icon: const Icon(Icons.timer))
                        ],
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  //duree
                  Container(
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
                        items: ['2','4','8'],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours["dure"]=value.toString();
                        }),
                        selectedItem: "Duree",
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  //salle
                  Container(
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
                        items: ListeSalle(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours["idsalle"]=value.toString();
                        }),
                        selectedItem: "Salle",
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  //Matiere
                  Container(
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
                        items: ListeMatiere(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours['idMatiere']=value.toString();
                        }),
                        selectedItem: 'Matiere',
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  //semestre
                  Container(
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
                        items: ["semestre I","semestre II"],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours['idSemestre']=value.toString();
                        }),
                        selectedItem: "Semestre",
                      ),
                    )
                  ),
                  const SizedBox(height: 20,),
                  Container(
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
                        items: ListeClasse(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) =>setState((){
                            BDCours['idClasse']=value.toString();
                        }),
                        selectedItem: 'Classe',
                      ),
                    )
                  ),
                  const SizedBox(height: 15),
                  ///Button
                  ElevatedButton(
                    onPressed:(){
                      InCours();
                    } ,
                    child: Container(
                      alignment:Alignment.center,
                      height:55,
                      width: 300,
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
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif'
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          )
        ),
      ) 
    )
    );
}

    List<String> ListeSalle(){
      List<String> list=[];
      listsal.get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            list.add(docSnapshot.data()['libelle']) ;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      return list;
    }

    List<String> ListeClasse(){
      List<String> list=[];
      listcla.get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            list.add(docSnapshot.data()['libelleclasse']) ;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      return list;
    }

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
  
    List<String> ListeEnseignant(){
      List<String> list=[];
      listens.get().then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            list.add(docSnapshot.data()['nom']) ;
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      return list;
    }

  }
