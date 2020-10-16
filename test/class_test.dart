import 'package:test/test.dart';
import 'package:ticket_booking_client/class/Payment.dart';
import 'package:ticket_booking_client/functions/validators.dart';

void main() {
  stringTest();
  testUserDetails();
}

void stringTest() {
  group('string validation', () {
    test('incorrect email should get an error', () {
      expect(false, validateEmail("incorrectemail"));
    });

    test('correct email should get true as reply', () {
      expect(true, validateEmail("correctmail@gmail.com"));
    });

    test('passwords should match if they are same', () {
      expect(true, confirmPass("matchingpass", "matchingpass"));
    });

    test('if passwords different, should get an error', () {
      expect(false, confirmPass("unequaledpass", "yesitsunequal"));
    });
  });
}

void testUserDetails() {
  test('payment to json converter', () {
    expect(
        {
          'payAmount': 100.0,
          "date": DateTime.parse("2020-10-16 21:12:22.053"),
          "type": "card"
        },
        Payment(100.0, DateTime.parse('2020-10-16 21:12:22.053'), 'card')
            .toJson());
  });
}
