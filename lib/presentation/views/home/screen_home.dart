import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:location_tracker/data/secure_storage/secure_storage.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/core/height_width.dart';
import 'package:location_tracker/presentation/views/home/bloc/bloc/location_tracker_bloc.dart';
import 'package:location_tracker/presentation/views/home/widgets/home_appbar.dart';
import 'package:location_tracker/presentation/views/home/widgets/location_deatils.dart';
import 'package:location_tracker/presentation/widgets/login_signup_button.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override 
  ScreenHomeState createState() => ScreenHomeState(); 
}

class ScreenHomeState extends State<ScreenHome> {

  SqfliteService service = SqfliteService();
  SecureStorage storage = SecureStorage();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const HomeAppbarWidget(title: "Location Tracker"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
              builder: (context, state) {
                if (state is LocationTrackerLoadingState) {
                  return kCircleIndicator;
                }
                if (state is LocationTrackerSuccessState) {
                  return LocationDetailWidget(latitude: state.latitude,longitude: state.longitude,);
                }  
                if (state is LocationTrackerErrorState) {
                  return const Center(child: Text('Failed to fetch location'));
                }  
                return const Center(child: Icon(Icons.location_off,size: 80,));
              },
            ), 
            kHeight30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: LoginSignUpButtonWidget( 
                text:'Fech Location',
                onPressed: ()async{
                 context.read<LocationTrackerBloc>().add(TrackLocationEvent()); 
                
              }, ),
            ),
            kHeight20,
            const Text('Grant permission to track location'),
           
          ],
        ),
      ),
    );
  } 
}


