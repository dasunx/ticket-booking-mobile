class Payment {
  final double payAmount;
  final DateTime date;
  final String type;

  Payment(this.payAmount, this.date, this.type);

  Map<String, dynamic> toJson() =>
      {'payAmount': payAmount, 'date': date, 'type': type};

  Payment.fromJson(Map<String, dynamic> json)
      : payAmount = json['payAmount'],
        date = json['date'],
        type = json['type'];
}
