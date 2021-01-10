class UserLocation {
  final int id;
  final String locDateTime;
  final double userLat;
  final double userLon;

  UserLocation({this.id, this.locDateTime, this.userLat, this.userLon});

  Map<String, dynamic> toMap() {
    return {
      'locDateTime': locDateTime,
      'userLat': userLat,
      'userLon': userLon,
    };
  }

  @override
  String toString() {
    return '$locDateTime,$userLat,$userLon,$id';
  }
}
