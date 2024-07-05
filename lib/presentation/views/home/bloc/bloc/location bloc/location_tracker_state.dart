part of 'location_tracker_bloc.dart';

@immutable
sealed class LocationTrackerState {}

class LocationTrackerInitial extends LocationTrackerState {}

class LocationTrackerLoadingState extends LocationTrackerState {}

class LocationTrackerSuccessState extends LocationTrackerState {
  final String latitude;
  final String longitude;
  final String timeStamp;

  LocationTrackerSuccessState({
    required this.latitude,
    required this.longitude,
    required this.timeStamp,
  });
}

class LocationTrackerErrorState extends LocationTrackerState {}

class LocationTrackerToggleState extends LocationTrackerState {
  final bool isTrackingEnabled;

  LocationTrackerToggleState({required this.isTrackingEnabled});
}
