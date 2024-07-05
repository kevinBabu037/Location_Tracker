import 'package:bloc/bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {


     SqfliteService service =SqfliteService();

    on<UserSignUpEvent>((event, emit) async{

      emit(SignUpLoadingState()); 

     final res = await service.addUser(event.user);

    
      // ignore: unnecessary_null_comparison
      if (res!=null) {
        emit(SignUpSuccessState());
      }else{
        emit(SignUpErrorState());
      }
       
    });
  }
} 
