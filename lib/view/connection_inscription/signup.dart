import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/pageAcceuil_Admin/home.dart';
import 'package:gestion_emploi_temps/view/widgets/reuisable.dart';

import '../../util/color_util.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController userNameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  Future createUsers({required String name,required String email,required String password}) async {

    final docUser=FirebaseFirestore.instance.collection('users').doc();
    final json={
      'id':docUser.id,
      'nom':name,
      'email':email,
      'password':password
    };
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation:0,
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
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
              children:<Widget>[
                const SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.fromLTRB(55,0,55,0),
                  child:Icon(
                      Icons.lock,
                      size: 200,
                      color: Colors.white,
                  ),
                ),
                const SizedBox( height: 30),
                const Text( 
                  'Inscription au compte',
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox( height: 20),
                reusableTextField("Entrer votre nom",Icons.person_outline, false, userNameController),
                const SizedBox( height: 20),
                reusableTextField("Entrer un email",Icons.person_outline, false, emailController),
                const SizedBox( height: 20),
                reusableTextField("Entrer un mot de passe",Icons.lock_outlined, true, passwordController),
                const SizedBox( height: 20),
                SignInSignUpButton(context, false, (){
                  if(emailController.text.trim()=='' || passwordController.text.trim()==''){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        ' veuillez remplir les champs.',
                        style: TextStyle(fontSize: 15, color: Colors.yellow),
                      )
                    ));
                  }else{
                    createUsers(name:userNameController.text.trim(),email:emailController.text.trim(),password:passwordController.text.trim());
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()
                      ).then((value){
                        Navigator.push(context,MaterialPageRoute(
                          builder:(context)=>const HomePageAdmin()));
                      }).onError((error, stackTrace){
                        print("Error ${error.toString()}");
                      });
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}