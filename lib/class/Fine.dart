import 'User.dart';

class Fine {
  double amount;
  double paidAmount;
  bool paid;
  DateTime date;
  DateTime paidDate;
  User manager;

  Fine.unPaidFinefromJson(Map<String, dynamic> json)
      : amount = double.parse(json['amount'].toString()),
        paid = json['paid'],
        paidAmount = double.parse(json['paidAmount'].toString()),
        date = DateTime.parse(json['time']),
        manager = User.managerFromJson(json['managerId']);

  Fine.fromJson(Map<String, dynamic> json)
      : amount = double.parse(json['amount'].toString()),
        paidAmount = double.parse(json['paidAmount'].toString()),
        paid = json['paid'],
        paidDate = DateTime.parse(json['paidTime']),
        date = DateTime.parse(json['time']),
        manager = User.managerFromJson(json['managerId']);
}
