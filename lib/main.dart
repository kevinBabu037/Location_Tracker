import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/repositories/sqlite%20service/auth_service.dart';
import 'package:location_tracker/data/repositories/geolocator/location_service.dart';
import 'package:location_tracker/data/shared_pref/shared_pref.dart';
import 'package:location_tracker/presentation/views/admin/bloc/all%20users/all_users_bloc.dart';
import 'package:location_tracker/presentation/views/admin/bloc/user%20location%20history/bloc/location_history_bloc.dart';
import 'package:location_tracker/presentation/views/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:location_tracker/presentation/views/authentication/login/screen_login.dart';
import 'package:location_tracker/presentation/views/authentication/signup/bloc/bloc/sign_up_bloc.dart';
import 'package:location_tracker/presentation/views/home/bloc/bloc/location%20bloc/location_tracker_bloc.dart';
import 'package:location_tracker/presentation/views/home/bloc/bloc/profile%20bloc/bloc/user_profile_bloc.dart';
import 'package:location_tracker/presentation/views/home/cubit/theme_cubit.dart';
import 'package:location_tracker/presentation/views/home/screen_home.dart';

final SqfliteService sqfliteService = SqfliteService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sqfliteService.initializeDatabase();
  bool isLoggedIn = await SharedPreferenses.getBoolValue() ?? false;

  runApp(MyApp(isLogin: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()), 
        BlocProvider(create: (context) => LocationHistoryBloc()), 
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => AllUsersBloc()),
        BlocProvider(create: (context) => ThemeCubit()), 
        BlocProvider(create: (context) => UserProfileBloc()), 
        BlocProvider(create: (context) => LocationTrackerBloc(locationService)), 
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, 
            theme: theme,
            title: 'Location Tracker',
            home: isLogin ? const ScreenHome() : ScreenLogIn(),
          );
        },
      ),
    );
  }
}
