part of 'location_history_bloc.dart';

@immutable
sealed class LocationHistoryState {}

//fech user location data

final class LocationHistoryInitial extends LocationHistoryState {}


final class LocationDataLoadingState extends LocationHistoryState {}

final class LocationDataSuccessState extends LocationHistoryState {
 final  List<LocationData> locationList;

  LocationDataSuccessState({required this.locationList});
}
final class LocationDataEmptyState extends LocationHistoryState {}

final class LocationDataErrorState extends LocationHistoryState {}
