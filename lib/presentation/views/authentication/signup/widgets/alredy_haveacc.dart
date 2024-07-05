
import 'package:flutter/material.dart';
import 'package:location_tracker/presentation/core/colors.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/views/authentication/login/screen_login.dart';

class AlredyHaveAccWidget extends StatelessWidget {
  const AlredyHaveAccWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
     children: [
      const Text('Already have an account?'),
       GestureDetector( 
         onTap: () {
            kNavigationPush(context, ScreenLogIn());
         },
         child: const Text(' Login',style: TextStyle(color: kClrBlue,fontSize: 16 ,fontWeight: FontWeight.bold),),
         ),
                   
     ],
       );
  }
}