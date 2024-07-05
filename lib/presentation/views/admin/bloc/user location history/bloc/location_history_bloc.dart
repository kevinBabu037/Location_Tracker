import 'package:bloc/bloc.dart';
import 'package:location_tracker/data/model/location.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:meta/meta.dart';

part 'location_history_event.dart';
part 'location_history_state.dart';

class LocationHistoryBloc extends Bloc<LocationHistoryEvent, LocationHistoryState> {
  LocationHistoryBloc() : super(LocationHistoryInitial()) {

      SqfliteService service = SqfliteService();




    on<GetLocationHistory>((event, emit)async {
       emit(LocationDataLoadingState()); 
  
      List<LocationData>? dataList = await service.getLocationHistory(event.id);

      if (dataList.isNotEmpty) { 
       emit(LocationDataSuccessState(locationList: dataList));
     } else if(dataList.isEmpty){
      emit(LocationDataEmptyState()); 
     }else{
        emit(LocationDataErrorState());
     }

    });
   
  }
}
