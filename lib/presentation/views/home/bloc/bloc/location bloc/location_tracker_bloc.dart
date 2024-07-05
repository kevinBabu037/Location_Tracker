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
  final SqfliteService service = SqfliteService();
  final SecureStorage storage = SecureStorage();
  Timer? _locationTimer;
  bool isTracking = false;

  LocationTrackerBloc(this.locationService) : super(LocationTrackerInitial()) {
    on<TrackLocationEvent>(_onTrackLocationEvent);
    on<ToggleTrackingEvent>(_onToggleTrackingEvent);
    on<LocationTrackerToggleEvent>(_onLocationTrackerToggleEvent);
  }

  Future<void> _onTrackLocationEvent(TrackLocationEvent event, Emitter<LocationTrackerState> emit) async {
    emit(LocationTrackerLoadingState());

    await _saveLocation(emit);

    if (isTracking) {
      _locationTimer?.cancel(); 
      _locationTimer = Timer.periodic(const Duration(minutes: 30), (timer) async {
        await _saveLocation(emit);
      });
    }
  }

  Future<void> _onToggleTrackingEvent(ToggleTrackingEvent event, Emitter<LocationTrackerState> emit) async {
    isTracking = event.isTrackingEnabled;
    emit(LocationTrackerToggleState(isTrackingEnabled: isTracking)); 

    if (isTracking) {
      add(TrackLocationEvent());
    } else {
      _locationTimer?.cancel();
    }
  }

  Future<void> _onLocationTrackerToggleEvent(LocationTrackerToggleEvent event, Emitter<LocationTrackerState> emit) async {
    isTracking = event.isTrackingEnabled;
    emit(LocationTrackerToggleState(isTrackingEnabled: isTracking)); 

    if (isTracking) {
      add(TrackLocationEvent());
    } else {
      _locationTimer?.cancel();
    }
  }

  Future<void> _saveLocation(Emitter<LocationTrackerState> emit) async {
    try {
      Position? position = await locationService.getCurrentLocation();
      // ignore: unnecessary_null_comparison
      if (position != null) {
        if (!emit.isDone) {
          emit(LocationTrackerSuccessState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            timeStamp: position.timestamp.toString(),
          ));
        }

        String id = await storage.readSecureData('userId');
        int userID = int.parse(id);

        await service.storeLocationData(
          LocationData(
            id: userID,
            latitude: position.latitude,
            longitude: position.longitude,
            timestamp: position.timestamp.toString(),
            userId: userID,
          ),
        );
      } else {
        if (!emit.isDone) {
          emit(LocationTrackerErrorState());
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(LocationTrackerErrorState());
      }
    }
  }

  @override
  Future<void> close() {
    _locationTimer?.cancel();
    return super.close();
  }
}
