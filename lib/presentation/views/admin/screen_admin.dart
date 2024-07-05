import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/views/admin/bloc/all%20users/all_users_bloc.dart';
import 'package:location_tracker/presentation/views/admin/widgets/admin_app_bar.dart';
import 'package:location_tracker/presentation/views/admin/widgets/user_details_tile.dart';

class ScreenAdmin extends StatelessWidget {
  const ScreenAdmin({super.key});

  @override  
  Widget build(BuildContext context) { 
    context.read<AllUsersBloc>().add(GetAllUsersEvent());  
    return Scaffold(   
      appBar:const AdminAppBarWidget(title:'Admin'),
      body: BlocBuilder<AllUsersBloc, AllUsersState>(
        builder: (context, state) {
          if (state is AllUsersLoadingState) { 
            return  kCircleIndicator;
          } 
          if (state is AllUsersSuccessState) {
           return ListView.separated(
              itemBuilder: (context, index) { 
                final data = state.users[index];
               return UserDetailsTile(data: data); 
              }, 
              separatorBuilder: (context, index) =>const Divider(thickness: 0.3,), 
              itemCount: state.users.length
              );
          }
          return const Center(child: Text('Fail to fech'),);
        },
      ),
    );
  }
}

