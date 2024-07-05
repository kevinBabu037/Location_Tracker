import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/shared_pref/shared_pref.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/core/height_width.dart';
import 'package:location_tracker/presentation/views/authentication/login/screen_login.dart';
import 'package:location_tracker/presentation/views/home/bloc/bloc/location%20bloc/location_tracker_bloc.dart';
import 'package:location_tracker/presentation/views/home/bloc/bloc/profile%20bloc/bloc/user_profile_bloc.dart';
import 'package:location_tracker/presentation/views/home/widgets/user_profile_name_email.dart';

Widget buildDrawer(BuildContext context) {
  context.read<UserProfileBloc>().add(GetUserProfileEvent());
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        kHeight30,
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              kPop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ),
        BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoadingState) {
              return kCircleIndicator;
            }
            if (state is UserProfileSuccessState) {
              return UserProfileNameEmailWdget(
                name: state.name,
                email: state.email,
              );
            }
            return const Center(
              child: Text('Failed to fetch profile'),
            );
          },
        ),
        kHeight20,
        const Divider(),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Tracking'),
          trailing: Switch(
            value: context.watch<LocationTrackerBloc>().isTracking,
            onChanged: (value) {
              context.read<LocationTrackerBloc>().add(ToggleTrackingEvent(isTrackingEnabled: value));
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () {
            // Navigate to privacy policy screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Navigator.pop(context);
            kShowDialog(
              context: context,
              title: 'Log Out',
              contentTxt: 'Are you sure you want to log out?',
              actionBtn1Txt: 'Cancel',
              actionBtn2Txt: 'Logout',
              onPressed: () {
                SharedPreferenses.deleteBool();
                kNavigationPushRemoveUntil(context, ScreenLogIn());
              },
            );
          },
        ),
      ],
    ),
  );
}
