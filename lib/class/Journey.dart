class Journey {
  final String startingPlace;
  String endingPlace;
  final DateTime startTime;
  DateTime endTime;
  String busId;
  double cost;

  Journey(this.startingPlace, this.endingPlace, this.startTime, this.endTime,
      this.cost);

  Journey.fromJson(Map<String, dynamic> json)
      : startingPlace = json['startPlace'],
        startTime = DateTime.parse(json['startTime']),
        cost = double.parse(json['cost'].toString()),
        busId = json['busId']['regNo'];

  Journey.fromJsonFull(Map<String, dynamic> json)
      : startingPlace = json['startPlace'],
        startTime = DateTime.parse(json['startTime']).toLocal(),
        endingPlace = json['endPlace'],
        endTime = DateTime.parse(json['endTime']).toLocal(),
        cost = double.parse(json['cost'].toString()),
        busId = json['busId']['regNo'];

  Journey.onGoingJourneyFromJson(Map<String, dynamic> json)
      : startingPlace = json['startingPlace'],
        startTime = json['startTime'];
}
