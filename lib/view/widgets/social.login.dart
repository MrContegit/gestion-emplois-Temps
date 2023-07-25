import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/global.colors.dart';

class SocialLogin extends StatelessWidget{
  const SocialLogin({Key? key}):super(key: key);

  @override
  Widget build( BuildContext context){
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '-Or sign in witch-',
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: Row(
            children: [
              ///google
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius:10,
                      )
                    ]
              
                  ),
                  child: SvgPicture.asset('assets/images/google.svg',height:25),
                ),
              ),
              const SizedBox(width: 10),
              ///Facebook
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius:10,
                      )
                    ]
                  ),
                  child: SvgPicture.asset('assets/images/facebook.svg',height:25),
                ),
              ),
              const SizedBox(width: 10),
              ///twitter
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius:10,
                      )
                    ]
                  ),
                  child: SvgPicture.asset('assets/images/twitter.svg',height:25),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}