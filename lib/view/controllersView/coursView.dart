import 'package:flutter/material.dart';
import '../../constante/lesIcons.dart';
import '../../partie_Cours/home.dart';
import '../pageSecondaire/crud/programmecours.dart';
import '../pageSecondaire/crud/supprimer.dart';
import 'ajoutermatiere.dart';
import 'datecle.dart';


class CoursView extends StatefulWidget {
  CoursView({super.key,this.map,this.map2});
  Map<String,String>? map;
  Map<int,String>? map2;

    
  @override
  State<CoursView> createState() => _CoursViewState();
}

class _CoursViewState extends State<CoursView> {
  int selectedIndex = 0;
  @override
  void initState() {
    wid();
    super.initState();
  }
  late List<Widget> widgetOptions;
  void wid(){
    widgetOptions = <Widget>[
      HomePage(map: widget.map,map2: widget.map2,),
      ProgrammeCours(),
      AjouterMatiere(),
      DateCle(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon:Image.asset(
              icaffiche,
              width: 30.0,
            ) ,
            activeIcon:const Icon(Icons.visibility,
            color: Colors.blue,
            weight:24.0
            ),
            label: 'afficher',
          ),
          BottomNavigationBarItem(
            icon:Image.asset(
              icAjouter,
              width: 30.0,
            ) ,
            activeIcon:const Icon(Icons.note_add,
            color: Colors.blue,
            weight:24.0
            ),
            label: 'ajouter',
          ),
          BottomNavigationBarItem(
            icon:Image.asset(
              icModifier,
              width: 30.0,
            ) ,
            activeIcon:const Icon(Icons.library_add,
            color: Colors.blue,
            weight:24.0
            ),
            label: 'ajouter matiere',
          ),
          BottomNavigationBarItem(
            icon:Image.asset(
              icDelete_programme,
              width: 30.0,
            ) ,
            activeIcon:const Icon(Icons.calendar_view_month,
            color: Colors.blue,
            weight:24.0
            ),
            label: 'date clé',
          ),

        ],
        currentIndex: selectedIndex,
        onTap: (int index){
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}