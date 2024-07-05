import 'package:flutter/material.dart';
import 'package:location_tracker/presentation/core/colors.dart';
import 'package:location_tracker/presentation/core/height_width.dart';

class LocationDetailWidget extends StatelessWidget {
  const LocationDetailWidget({
    super.key, required this.latitude, required this.longitude,
  });

  final String latitude;
  final String longitude;

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
       child: Column(
         children: [
          const Icon(Icons.location_on,size: 100 ,color: kClrBlue,),
           kHeight20,
           Text("Latitude: $latitude",style:const TextStyle(fontSize: 20 ),),
           kHeight10,
           Text("Longitude: $longitude",style:const TextStyle(fontSize: 20 )) 
         ],
       ),
     );
  }
}