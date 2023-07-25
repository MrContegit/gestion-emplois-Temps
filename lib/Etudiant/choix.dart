import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_emploi_temps/Etudiant/pgcours.dart';
import 'package:gestion_emploi_temps/partie_Cours/home.dart';

class CustomCarouselFB2 extends StatefulWidget {
  const CustomCarouselFB2({Key? key}) : super(key: key);

  @override
  _CustomCarouselFB2State createState() => _CustomCarouselFB2State();
}

class _CustomCarouselFB2State extends State<CustomCarouselFB2> {


  List<Widget> cards = [
    CardFb1(
        text: "Consulter Cours de la Semaine",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
        subtitle: "",
        onPressed: () {}),
    CardFb1(
        text: "Consulter programme du soir",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Designer_re_5v95%201.png?alt=media&token=5d053bd8-d0ea-4635-abb6-52d87539b7ec",
        subtitle: "",
        onPressed: () {}),
    CardFb1(
        text: "creer un programme",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Accept_terms_re_lj38%201.png?alt=media&token=476b97fd-ba66-4f62-94a7-bce4be794f36",
        subtitle: "",
        onPressed: () {}),
    
  ];

  final double carouselItemMargin = 16; 

  late PageController _pageController;
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: .7);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: cards.length,
        onPageChanged: (int position) {
          setState(() {
            _position = position;
          });
        },
        itemBuilder: (BuildContext context, int position) {
          return imageSlider(position);
        });
  }

  Widget imageSlider(int position) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return Container(
          margin: EdgeInsets.all(carouselItemMargin),
          child: Center(child: widget),
        );
      },
      child: Container(
        child: cards[position],
      ),
    );
  }
}

class CardFb1 extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

 CardFb1(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);
      
    final TextEditingController classeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        if(text =="Consulter Cours de la Semaine"){
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
                      Map<String,String>? mape = {
                        'classe' :classeController.text.trim(),
                        'semaine' :'jj/mm/aa..',
                        'semestre' :'semestre II',
                        'salle' :'CH254'
                      };
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>PgCours(map: mape,)),
                      (Route<dynamic> route) => false);
                    },
                  ),
                ],
              );
            });
                    
        }else if(text=="Consulter programme du soir"){

        }else if(text=="creer un programme"){

        }
      },
      child: Container(
        width: 250,
        height: 230,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 90, fit: BoxFit.cover),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
