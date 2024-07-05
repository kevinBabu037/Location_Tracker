import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/presentation/views/home/cubit/theme_cubit.dart';


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
      
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}





