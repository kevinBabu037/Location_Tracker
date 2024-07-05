import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/presentation/core/functions_navigations.dart';
import 'package:location_tracker/presentation/views/admin/bloc/user%20location%20history/bloc/location_history_bloc.dart';
import 'package:location_tracker/presentation/views/admin/widgets/user_location_history_tile.dart';

class LocationDataWidget extends StatefulWidget {
  const LocationDataWidget({super.key, required this.user});

 final UserModel user;

  @override
  State<LocationDataWidget> createState() => _LocationDataWidgetState();
}

class _LocationDataWidgetState extends State<LocationDataWidget> {

  @override
  void initState() { 
    context.read<LocationHistoryBloc>().add(GetLocationHistory(id: widget.user.id!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,  
        title: Text("${widget.user.name}'s Location History"),
      ),
      body: BlocBuilder<LocationHistoryBloc, LocationHistoryState>(
        builder: (context, state) { 
          if (state is LocationDataLoadingState) { 
            return kCircleIndicator;
          }  
          if (state is LocationDataSuccessState) {
           return ListView.separated(  
              itemBuilder: (context, index) { 
                final data = state.locationList[index];
                String dateTime = kFormatTimestamp(data.timestamp);
               return UserLocationHistoryTile(data: data, dateTime: dateTime);  
              }, 
              separatorBuilder: (context, index) =>const Divider(thickness: 0.3,), 
              itemCount: state.locationList.length
              );
          }
          if (state is LocationDataEmptyState) {
            return const Center(child: Text('List is empty'),);
          }
          return const Center(child: Text('Fail to fech'),);
        },
      ),
    );
  }
}

