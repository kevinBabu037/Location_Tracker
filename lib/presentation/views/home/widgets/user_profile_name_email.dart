import 'package:flutter/material.dart';
import 'package:location_tracker/presentation/core/height_width.dart';

class UserProfileNameEmailWdget extends StatelessWidget {
  const UserProfileNameEmailWdget({
    super.key, required this.name, required this.email,
  });
  final String name ;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column( 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person,size: 50,),
               ),
               kHeight10,
               Text(name,style:const TextStyle(fontSize: 18),),
               Text(email,style:const TextStyle(fontSize: 16),)
            ],
          );
  }
}