

import 'package:bloc/bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:meta/meta.dart';

part 'all_users_event.dart';
part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsersBloc() : super(AllUsersInitial()) {
 
   SqfliteService service = SqfliteService();

   List<UserModel> allUsers = []; 

    on<GetAllUsersEvent>((event, emit)async {
       emit(AllUsersLoadingState()); 
  
       allUsers = await service.getAllUsers();
 
      if (allUsers.isNotEmpty) { 
       emit(AllUsersSuccessState(users: allUsers));
     }else{
      emit(AllUsersErrorState()); 
     }

    });

   on<DeleteUserEvent>((event, emit)async {
 
      await service.deleteUser(event.id);
      allUsers = await service.getAllUsers();
 
      if (allUsers.isNotEmpty) {
       emit(AllUsersSuccessState(users: allUsers));
     }else{
      emit(AllUsersErrorState());
     }

    });



    


  }
  
}
