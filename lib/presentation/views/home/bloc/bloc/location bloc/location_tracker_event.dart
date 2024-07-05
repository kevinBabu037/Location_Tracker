part of 'location_tracker_bloc.dart';

@immutable
sealed class LocationTrackerEvent {}

class TrackLocationEvent extends LocationTrackerEvent {}

class ToggleTrackingEvent extends LocationTrackerEvent {
  final bool isTrackingEnabled;

  ToggleTrackingEvent({required this.isTrackingEnabled});
}

class LocationTrackerToggleEvent extends LocationTrackerEvent {
  final bool isTrackingEnabled;

  LocationTrackerToggleEvent({required this.isTrackingEnabled});
}
