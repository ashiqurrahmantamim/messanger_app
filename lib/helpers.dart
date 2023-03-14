import 'dart:math';

abstract class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static DateTime randomDate() {
    final int randomInt=random.nextInt(20000);
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds:randomInt));
  }
}
