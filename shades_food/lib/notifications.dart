import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shades_food/utilities.dart';
// import 'package:foodshades/utilities.dart';

Future<void> createFoodNotifications() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title:
          '${Emojis.money_money_bag + Emojis.food_bacon}  Collect your food items!!!!',
      body: 'Come now',
      bigPicture:
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Fgold-alphabet-letter-fs-f-s-logo-combination-icon-design-suitable-company-business-121480041.jpg&imgrefurl=https%3A%2F%2Fwww.dreamstime.com%2Fgold-alphabet-letter-fs-f-s-logo-combination-icon-design-suitable-company-business-image121480041&tbnid=YfsTCL-AoTJtQM&vet=12ahUKEwj8-PTh7NrzAhWOm0sFHazQDHAQMygBegUIARCDAQ..i&docid=LriCmtF_Rgg6VM&w=800&h=516&q=fs&ved=2ahUKEwj8-PTh7NrzAhWOm0sFHazQDHAQMygBegUIARCDAQ',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
