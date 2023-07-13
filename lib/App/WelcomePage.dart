import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galerie/widgets/AppLargeText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../widgets/AnnimationApp.dart';
import '../widgets/buttonWidget.dart';
import 'Grille.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("img/papillon.jpg"),
          fit: BoxFit.cover,
          ),
        ),
        child:Container(
          margin:  const EdgeInsets.only(top: 150,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimationApp(delay: 2000,
              child: AppLargeText(text: "Votre Galerie", color: Colors.white, size: 50,),),
              SizedBox(height: 500,),
              AnimationApp(
                delay: 3500,
                child: InkWell(
                  onTap: (){
                    Get.to(()=>GridPage(), transition: Transition.fadeIn, duration: Duration(seconds: 1));
                  },
                  child:  ButtonWidget(backgroundcolor: CupertinoColors.tertiaryLabel.withOpacity(0.6), text: 'Go', textColor: Colors.white,),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
