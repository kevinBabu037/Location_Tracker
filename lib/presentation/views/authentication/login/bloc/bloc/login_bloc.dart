import 'package:bloc/bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

 SqfliteService service =SqfliteService();

    on<UserLogin>((event, emit)async {
    
    UserModel? res = await service.loginUser(event.email, event.password);

    if (res!=null) {
      emit(LoginSuccessState());
    }else if(event.password=='Admin123#'&&event.email=='admin@gmail.com'){
       emit(AdminSuccessState());
    }
    else{
      emit(LoginErrorState());
    }

      
    });
  }
}
