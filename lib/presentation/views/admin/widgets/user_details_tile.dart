import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/views/admin/bloc/all%20users/all_users_bloc.dart';
import 'package:location_tracker/presentation/views/admin/widgets/location_data.dart';

class UserDetailsTile extends StatelessWidget {
  const UserDetailsTile({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
     leading:const CircleAvatar( 
       child: Icon(Icons.person),
     ),
     title: Text(data.name),  
     subtitle: Text(data.email),
     trailing: IconButton(
       onPressed: (){
         kShowDialog(context: context, title: 'Delete', contentTxt: "Are you sure want to delete ${data.name}", actionBtn1Txt: 'cancel', actionBtn2Txt: "delete",
          onPressed: (){
           context.read<AllUsersBloc>().add(DeleteUserEvent(id: data.id!));
           kPop(context);
         }); 
       }, 
     icon:const Icon(Icons.delete)),
     onTap: () {
       kNavigationPush(context, LocationDataWidget(user: data,));
     },
    );
  }
}