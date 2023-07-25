import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/widgets/reuisable.dart';
import '../../util/color_util.dart';
import '../pageAcceuil_Admin/premierePage_admiinistrateur.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController emailController=TextEditingController();


   Future signIn() async{
    if(emailController.text.trim()=='' || passwordController.text.trim()==''){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            ' veuillez remplir les champs.',
            style: TextStyle(fontSize: 15, color: Colors.yellow),
          )
        ));
    }else{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const Center(child: CircularProgressIndicator(),));
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value){
     // if(value){
        Navigator.push(context,
          MaterialPageRoute( builder:(context)=>const AdminHomePage())).onError((error, stackTrace){
            print("Error ${error.toString()}");
          }
        ); 
     /* }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Vous n\'etes pas inscrit.',
          style: TextStyle(fontSize: 15,color: Colors.blue),
        )
      ));
      }*/
      });
    }
    }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            hexstringToColor("1E319D"),
            hexstringToColor("4974a5"),
            hexstringToColor("5E61F4")
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,120,20,0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:<Widget>[
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(75,0,20,0),
                  child:Icon(
                      Icons.lock,
                      size: 200,
                      color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                const Text( 
                  'Connexion au compte',
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox( height: 15),
                reusableTextField("Entrer un email",Icons.person_outline, false, emailController),
                const SizedBox( height: 20),
                reusableTextField("Entrer un mot de passe",Icons.lock_outlined, true, passwordController),
                const SizedBox( height: 20),
                SignInSignUpButton(context, true, signIn),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          const Text(
            'Vous n\'avez pas de compte?',
          ),
          GestureDetector(
            onTap:(){
             Navigator.push(context,
              MaterialPageRoute(builder:(context)=>const SignUp())); 
            },
            //InkWell(
            child: Text(
              ' Inscription',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          //),

        ],

      ),
    ),
    );
  }
}