part of 'location_tracker_bloc.dart';

@immutable
sealed class LocationTrackerEvent {}


final class TrackLocationEvent extends LocationTrackerEvent {}

class ToggleSwitchEvent extends LocationTrackerEvent {
  final bool isTrackingEnabled;

  ToggleSwitchEvent(this.isTrackingEnabled);
}