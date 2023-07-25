
import 'package:flutter/material.dart';



class HeadList extends StatelessWidget {
  final int selected;
  final Function callback;
  const HeadList(this.selected,this.callback,{super.key});

  @override
  Widget build(BuildContext context) {
    final Category = ['Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'];
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 25),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index)=>GestureDetector(
          onTap: ()=>callback(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selected ==index ? Colors.blue: Colors.black.withOpacity(0.4),
            ),
            child:  Text(
              Category[index],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
            ),
          ),
        ), 
        separatorBuilder: (_,index)=> SizedBox(width: 20,), 
        itemCount: Category.length
      )
    );
  }
}