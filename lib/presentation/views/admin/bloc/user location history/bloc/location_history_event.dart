part of 'location_history_bloc.dart';

@immutable
sealed class LocationHistoryEvent {}

class GetLocationHistory extends LocationHistoryEvent {
  final int id;

  GetLocationHistory({required this.id});
}