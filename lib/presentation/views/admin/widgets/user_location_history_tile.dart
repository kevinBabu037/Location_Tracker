import 'package:flutter/material.dart';
import 'package:location_tracker/data/model/location.dart';
import 'package:location_tracker/data/repositories/url_luncher/url_luncher.dart';

class UserLocationHistoryTile extends StatelessWidget {
  const UserLocationHistoryTile({
    super.key,
    required this.data,
    required this.dateTime,
  }); 

  final LocationData data;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        MapLauncher.launchMap(data.latitude, data.longitude);
      },
      leading: const CircleAvatar(
        child: Icon(Icons.location_on),
      ),
      title: Text("Lat: ${data.latitude} Lon: ${data.longitude}"),
      subtitle: Text(dateTime),
    );
  }
}
