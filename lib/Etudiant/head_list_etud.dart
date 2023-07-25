import 'package:flutter/cupertino.dart';

import '../partie_Cours/afficher_cours.dart';

class HeadListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;

  HeadListView(this.selected, this.callback, this.pageController,{required this.map,super.key, required this.map2});
    final Map<String,String> map;
    final Map<int,String> map2;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index) =>callback(index) ,
        children:[
          AfficherCours(map:map,numSem:map2[1]),
          AfficherCours(map:map,numSem:map2[2]),
          AfficherCours(map:map,numSem:map2[3]),
          AfficherCours(map:map,numSem:map2[4]),
          AfficherCours(map:map,numSem:map2[5]),
          AfficherCours(map:map,numSem:map2[6]),
        ]
      ),
    );
  }
}