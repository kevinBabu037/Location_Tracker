import 'package:flutter/material.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/views/authentication/login/screen_login.dart';

class AdminAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AdminAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            kShowDialog(
              context: context,
              title: 'Admin Logout',
              contentTxt: 'Are you sure want to logout',
              actionBtn1Txt: 'cancel',
              actionBtn2Txt: 'Logout',
              onPressed: () {
                kNavigationPushRemoveUntil(context, ScreenLogIn());
              },
            );
          },
          icon: const Icon(Icons.logout_outlined),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
