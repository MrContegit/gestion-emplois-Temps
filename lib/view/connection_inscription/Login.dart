import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/view/connection_inscription/signup.dart';
import 'package:gestion_emploi_temps/view/widgets/social.login.dart';
import 'package:gestion_emploi_temps/view/widgets/text.form.global.dart';
import '../../util/global.colors.dart';
import 'package:gestion_emploi_temps/view/pageAcceuil_Admin/home.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();  
  Future signIn() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const Center(child: CircularProgressIndicator(),));
    try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value){
        Navigator.push(context,
          MaterialPageRoute( builder:(context)=>const HomePageAdmin())).onError((error, stackTrace){
            print("Error ${error.toString()}");
          }); 
        });
    } on FirebaseAuthException catch(e){
      print(e);
    }
   // navigatorKey.currentState!.popUntil((route)=>route.isFirst );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child:SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Logo',
                  style: TextStyle(
                  color: GlobalColors.mainColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text( 
                'Logo to your account',
                style: TextStyle(
                color:GlobalColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),

              ///Email input
              TextFormGlobal(
                controller: emailController,
                text: 'Email',
                textInputType:TextInputType.emailAddress,
                obscure: false,
              ),

              const SizedBox(height: 10),
              ///password input
              TextFormGlobal(
                controller: passwordController,
                text: 'Password',
                textInputType:TextInputType.visiblePassword,
                obscure: true,
              ),

              const SizedBox(height: 15),
              ///Button
              ElevatedButton(
                onPressed: signIn,
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
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ),
              const SizedBox(height: 40),
              const SocialLogin(),
            ],
          )
        ),
      ) 
    ),
    bottomNavigationBar: Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          const Text(
            'Don\'t have an account?',
          ),
          GestureDetector(
            onTap:(){
             Navigator.push(context,
              MaterialPageRoute(builder:(context)=>const SignUp())); 
            },
            //InkWell(
            child: Text(
              ' Sign Up',
              style: TextStyle(
                color: GlobalColors.mainColor,
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