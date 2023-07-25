import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_emploi_temps/controllers/lesclasse.dart';
import 'package:gestion_emploi_temps/view/controllersView/salleView.dart';
import 'package:gestion_emploi_temps/view/pageSecondaire/crud/programmecours.dart';
import '../../models/category.dart';
import '../controllersView/coursView.dart';
import '../controllersView/enseignantView.dart';
import '../controllersView/lesClassesView.dart';

class HomePageAdmin extends StatefulWidget {

  
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  
      @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children:[
            SizedBox(height: 50,),
            AppEntete(),
            Body(),
          ],
        ),
      ),
    ); 
  }
}

class Body extends StatefulWidget{
  const Body({ Key? key}) : super(key :key);

  @override
  State<Body> createState() => _BodyState();

}
class _BodyState extends State<Body>{
    @override
  Widget build(BuildContext context){
    //Body page d acceuil de l administrateur
    return Column(
      children: [
        SizedBox(height: 20,),
        Padding(
          padding:  const EdgeInsets.only( top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text('CATEGORIE',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
              SizedBox(width: 10,),
              Icon(Icons.auto_stories,
              color: Colors.blueGrey,)
              
            ],
          ),
        ),
        Divider(
          height: 55,
          thickness: 3.5,
          color: Colors.blue.withOpacity(0.3),
          indent: 32,
          endIndent: 32,
        ),
        
        GridView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24
            ), 
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap:(){
                if(categoryList[index].name=="cours"){
                  Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>  CoursView())
                  ); 
                }else if(categoryList[index].name=="classes"){
                  Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>const LesClasseView())
                  );
                }else if(categoryList[index].name=="enseignants"){
                  Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>const EnseignantView())
                  );
                }else if(categoryList[index].name=="salles"){
                  Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>const SalleView())
                  );
                }
                
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 4.0,
                      spreadRadius: .05,
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        categoryList[index].thumbnail,
                        height:150,
                      ),
                    ),
                    Text(categoryList[index].name,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight:FontWeight.w600,
                      fontFamily: 'serif',
                      fontSize: 20,
                    ),
                    ),
                    const SizedBox(height: 6,),
                    Text(
                      'nombre :${categoryList[index].moofCourses.toString()}',
                      style: const TextStyle(
                      fontWeight:FontWeight.w300,
                      fontFamily: 'serif', 
                      fontSize: 15,
                    ),
                    )
                  ],
                ),
              ),
            );
          })
        )
      ],
    );
  }
}

class AppEntete extends StatefulWidget {
  const AppEntete({super.key});

  @override
  State<AppEntete> createState() => _AppEnteteState();
}

class _AppEnteteState extends State<AppEntete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.blue.withOpacity(0.7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            'Bonjour,'
             '\nMonsieur Conte',
            style:TextStyle(
              color: Colors.white,
              fontFamily:'serif',
              fontSize: 25
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
            shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
            color: Colors.white,
            ),
          )
            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

 