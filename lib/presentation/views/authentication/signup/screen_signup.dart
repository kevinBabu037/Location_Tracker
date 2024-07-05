
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:location_tracker/presentation/core/colors.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/core/height_width.dart';
import 'package:location_tracker/presentation/core/validation.dart';
import 'package:location_tracker/presentation/views/authentication/signup/bloc/bloc/sign_up_bloc.dart';
import 'package:location_tracker/presentation/views/authentication/signup/widgets/alredy_haveacc.dart';
import 'package:location_tracker/presentation/views/home/screen_home.dart';
import 'package:location_tracker/presentation/widgets/auth_textformfild.dart';
import 'package:location_tracker/presentation/widgets/login_signup_button.dart';
import 'package:location_tracker/presentation/widgets/login_signup_text.dart';
import 'package:location_tracker/presentation/widgets/signup_login_loading.dart';

class ScreenSignup extends StatelessWidget {
   ScreenSignup({super.key});
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
 final SqfliteService service = SqfliteService();

  @override
  Widget build(BuildContext context) { 
    TextEditingController nameController = TextEditingController();
    TextEditingController eMailController = TextEditingController();
    TextEditingController passWordController = TextEditingController(); 
    return  Scaffold(
      body: SafeArea(  
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15), 
          child: SingleChildScrollView( 
            child: Form(
              key: _formKey,
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
               ////section1
               
              const LoginSignUpHedingWidget( 
                    title: 'Create Account',
                    text: 'Sign up to get started', 
                   ),
              
               ////section2
                 
                 kHeight30, 
                  
                  const Text('Name',style:TextStyle(color:kClrGrey),),  
                   BuildTextFormField( 
                    controller: nameController,
                  hintTxt:'Enter Name',
                  prfixIcon: Icons.person_outlined, 
                  validator: (value) {
                    return  validateNameAndUserName(value);
                  },
                  ),
                
                  kHeight30,
                  
                  const Text('Email',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                    validator:(value) {
                    return validateEmail(value); 
                      
                    },
                    controller: eMailController,
                  hintTxt:'Enter Email', 
                  prfixIcon: Icons.email_outlined, 
                  ),
                
                  kHeight20,
                  
                  const Text('Password',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                  controller:passWordController ,
                  hintTxt:'Enter Password',  
                  prfixIcon: Icons.lock_outlined, 
                  validator: (value) {
                    return validatePassword(value); 
                  }, 
                  ),
                
                 kHeight50,
                
               ////section3   
                 BlocConsumer<SignUpBloc, SignUpState>(
                   listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      kNavigationPushRemoveUntil(context,const ScreenHome());
                    }else if(state is SignUpErrorState){
                      kSnakBar(context, 'Fail to SignIn', kClrRed);
                    }
                   },
                   builder: (context, state) {
                     if (state is SignUpLoadingState) {
                      return const SignUpLoadingWidget(title:'Sign Up',);
                     } 
                     return LoginSignUpButtonWidget(
                        text: 'Sign Up',
                       onPressed: ()async {
                           if (_formKey.currentState!.validate()) {
                            context.read<SignUpBloc>().add(UserSignUpEvent(
                        user: UserModel(email: eMailController.text, name: nameController.text, password: passWordController.text),
                        ));
                        }},
                         );
                   },
                 ),
                 kHeight20,
                    
                const AlredyHaveAccWidget()
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

