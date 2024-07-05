import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/shared_pref/shared_pref.dart';
import 'package:location_tracker/presentation/views/authentication/login/screen_login.dart';
import 'package:location_tracker/presentation/views/home/cubit/theme_cubit.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppbarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return IconButton(
              icon: Icon(theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          },
        ),
        IconButton(
          onPressed: () {
           kShowDialog(
            context: context, title: 'Log Out', 
            contentTxt: 'Are you sure want to logout?', 
            actionBtn1Txt: 'Cancel', 
            actionBtn2Txt: 'Logout', 
            onPressed: (){
               SharedPreferenses.deleteBool();
            kNavigationPushRemoveUntil(context, ScreenLogIn());
            });
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
