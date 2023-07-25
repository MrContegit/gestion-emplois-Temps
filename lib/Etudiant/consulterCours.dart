import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConsulterCours extends StatefulWidget {
  const ConsulterCours({super.key});

  @override
  State<ConsulterCours> createState() => _ConsulterCoursState();
}

class _ConsulterCoursState extends State<ConsulterCours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/salle.jfif'
                  )
                )
              ),
            )
          ),
          Positioned(
            top: 50,
            left: 30,
            right: 40,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color:Colors.blue,
                    size: 16,
                  ),
                )
              ],
            )
          )

        ],
      ),
    );
  }
}