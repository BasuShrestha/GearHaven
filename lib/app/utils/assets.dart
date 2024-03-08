import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  // icons from svg
  static final homeIcon = SvgPicture.asset('assets/svgs/home.svg');
  static final buyIcon = SvgPicture.asset('assets/svgs/buy.svg');
  static final sellIcon = SvgPicture.asset('assets/svgs/sell.svg');
  static final rentIcon = SvgPicture.asset('assets/svgs/rent.svg');
  static final profileIcon = SvgPicture.asset('assets/svgs/profile.svg');

  // images
  static const String profileImagePlaceholder =
      "assets/imgs/ProfileImagePlaceholder.jpg";
  static const String simpleProfilePlaceholder =
      "assets/imgs/SimpleProfilePlaceholder.png";
  static const String cartItemImagePlaceholder =
      "assets/imgs/CartItemPlaceholder.jpg";
}
