import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/data/model/location.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';

import 'package:location_tracker/data/repositories/geolocator/location_service.dart';
import 'package:location_tracker/data/secure_storage/secure_storage.dart';
import 'package:meta/meta.dart';

part 'location_tracker_event.dart';
part 'location_tracker_state.dart';

class LocationTrackerBloc extends Bloc<LocationTrackerEvent, LocationTrackerState> {
  final LocationService locationService;
  SqfliteService service =SqfliteService();
  SecureStorage storage =SecureStorage();

  LocationTrackerBloc(this.locationService) : super(LocationTrackerInitial()) {
    on<TrackLocationEvent>(_onTrackLocationEvent);
  }

  Future<void> _onTrackLocationEvent(TrackLocationEvent event, Emitter<LocationTrackerState> emit) async {
    emit(LocationTrackerLoadingState()); 

    try {
      Position? position = await locationService.getCurrentLocation(); 
      // ignore: unnecessary_null_comparison
      if (position != null) {
        emit(LocationTrackerSuccessState(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          timeStamp: position.timestamp.toString(), 
        ));
       String id = await storage.readSecureData('userId');
       int userID =int.parse(id);

       await service.storeLocationData( 
        LocationData(id:userID, 
        latitude: position.latitude, 
        longitude:position.longitude, 
        timestamp:position.timestamp.toString(),
         userId: userID
        ));
        
      } else {
        emit(LocationTrackerErrorState()); 
      }
    } catch (e) {  
      emit(LocationTrackerErrorState());
    }
  }

 
  
}
