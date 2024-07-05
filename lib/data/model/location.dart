class LocationData {
  final int? id;
  final int userId;
  final double latitude;
  final double longitude;
  final String timestamp;

  LocationData({
    this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      id: map['id'],
      userId: map['userId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: map['timestamp'],
    );
  }
}
