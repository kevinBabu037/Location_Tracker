
import 'package:bloc/bloc.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:location_tracker/data/secure_storage/secure_storage.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    SqfliteService service = SqfliteService();

    on<GetUserProfileEvent>((event, emit)async {

        emit(UserProfileLoadingState());

       String id = await SecureStorage().readSecureData('userId');
         Map<String, String> user = await service.getUserEmailAndName(int.parse(id));

         if (user.isNotEmpty) {
          String name = user.values.last;
          String email = user.values.first;
           emit(UserProfileSuccessState(name:name,email:email));
         }else{
          emit(UserProfileErrorState());
         }
          
           

    });
  }
}
