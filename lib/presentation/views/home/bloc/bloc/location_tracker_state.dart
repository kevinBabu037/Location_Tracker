part of 'location_tracker_bloc.dart';

@immutable
sealed class LocationTrackerState {}

final class LocationTrackerInitial extends LocationTrackerState {}

final class LocationTrackerLoadingState extends LocationTrackerState {}

final class LocationTrackerSuccessState extends LocationTrackerState {
 final String  latitude;
 final String longitude;
final String timeStamp;

  LocationTrackerSuccessState({required this.latitude, required this.longitude, required this.timeStamp});


}


final class LocationTrackerErrorState extends LocationTrackerState {}


/////////////sdded  



class SwitchStateChanged extends LocationTrackerState {
  final bool isTrackingEnabled;

  SwitchStateChanged(this.isTrackingEnabled);
}




