import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/partie_Cours/home.dart';
import 'package:gestion_emploi_temps/view/controllersView/coursView.dart';
import 'package:intl/intl.dart';
class UserEtud extends StatefulWidget {
  const UserEtud({super.key, required this.map});
  final Map<String,String>? map;
  
  @override
  State<UserEtud> createState() => _UserEtudState();
}

class _UserEtudState extends State<UserEtud> {
  late String selectedyear='annee';
  late String selectedmonth='mois';
  late String selectedday='jour';
  var formateur = DateFormat('EEEE');
  late String jour_semaine = '';
  late TimeOfDay _time=TimeOfDay.now();
  
  DateTime dates(){
    final now = DateTime.now();
    final lastDayOfWeek = now.subtract(Duration(days: now.weekday - DateTime.saturday));
    return lastDayOfWeek;
  }
  Map<int,String> map2={
    1:'',
    2:'',
    3:'',
    4:'',
    5:'',
    6:'',
  };
  void dates2(DateTime date){
    late DateTime lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.saturday));
    map2[6] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.friday));
    map2[5] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.thursday));
    map2[4] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.wednesday));
    map2[3] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.tuesday));
    map2[2] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    lastDayOfWeek = date.subtract(Duration(days: date.weekday - DateTime.monday));
    map2[1] = '${lastDayOfWeek.day}/${lastDayOfWeek.month}/${lastDayOfWeek.year}';
    
  }
  Future datecours() async {
    final date =await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate:DateTime.now(),
      lastDate: DateTime(2100));
      if (date != null) {
        dates2(date);
        setState(() {
          selectedyear = date.year.toString();
          selectedmonth = date.month.toString();
          selectedday = date.day.toString();
          semaines = '${selectedday}/${selectedmonth}/${selectedyear}';
          jour_semaine = formateur.format(date);
        });
      }
  }
   
  TextEditingController classeController = TextEditingController();
  String semaines = '';
  TextEditingController salleController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed:(){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Classe',
                              style:TextStyle(
                                color:Colors.blue,
                              )
                            ),
                            content:TextFormField(
                              controller: classeController,
                              decoration: const InputDecoration(hintText: "Entrez le nom  de la classe"),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('valider'),
                                onPressed: () {
                                    widget.map!['classe'] = classeController.text.trim();
                                      widget.map!['semaine'] = '${dates().day}/${dates().month}/${dates().year}';
                                      if(dates().month<=2 || dates().month>8){
                                        widget.map!['semestre'] ='semestre I';
                                      }
                                  Navigator.push(context,
                                  MaterialPageRoute(builder:(context)=> CoursView(map: widget.map,map2:map2)),
                        );
                                },
                              ),
                            ],
                          );
                        });
                    } ,
                    child: Text(
                      'Classe : ${widget.map!['classe']}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${widget.map!['semestre']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'serif'
                          ),
                        )
                      ),
                      const SizedBox(width: 40,),
                      TextButton(
                        onPressed:(){
                          showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'semaine',
                                      style:TextStyle(
                                        color:Colors.blue,
                                      )
                                    ),
                  content:ElevatedButton(
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
                            '${selectedday}/${selectedmonth}/${selectedyear}',
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
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('CANCEL'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('valider'),
                                        onPressed: () {
                                           //map!['classe'] = classeController.text.trim();
                                              widget.map!['semaine'] = semaines;
                                              if(dates().month<=2 || dates().month>8){
                                                widget.map!['semestre'] ='semestre I';
                                              }
                                          Navigator.push(context,
                                          MaterialPageRoute(builder:(context)=> CoursView(map: widget.map,map2:map2)),);
                                        },
                                      ),
                                    ],
                                  );
                                });

                        } ,
                        child: Text(
                          'Programme\n du ${widget.map!['semaine']}',
                          style: TextStyle(
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                            color: Colors.red.withOpacity(0.8),
                      
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}