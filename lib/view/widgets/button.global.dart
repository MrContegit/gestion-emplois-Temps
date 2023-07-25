import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/util/global.colors.dart';

class ButtonGlobal extends StatelessWidget{
  const ButtonGlobal ({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      child: Container(
        alignment:Alignment.center,
        height:55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color:Colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ]
        ),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: () async{
      },
      
    );
  }
}