class Journey {
  final String startingPlace;
  String endingPlace;
  final DateTime startTime;
  DateTime endTime;
  double cost;

  Journey(this.startingPlace, this.endingPlace, this.startTime, this.endTime,
      this.cost);

  Journey.fromJson(Map<String, dynamic> json)
      : startingPlace = json['startingPlace'],
        endingPlace = json['endingPlace'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        cost = json['cost'];

  Journey.onGoingJourneyFromJson(Map<String, dynamic> json)
      : startingPlace = json['startingPlace'],
        startTime = json['startTime'];
}
