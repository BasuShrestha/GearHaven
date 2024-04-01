import 'package:get/get.dart';

import '../modules/Orders_page/bindings/orders_page_binding.dart';
import '../modules/Orders_page/views/orders_page_view.dart';
import '../modules/active_rentings/bindings/active_rentings_binding.dart';
import '../modules/active_rentings/views/active_rentings_view.dart';
import '../modules/buy_page/bindings/buy_page_binding.dart';
import '../modules/buy_page/views/buy_page_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/draft/bindings/draft_binding.dart';
import '../modules/draft/views/draft_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/orders_delivery/bindings/orders_delivery_binding.dart';
import '../modules/orders_delivery/views/orders_delivery_view.dart';
import '../modules/product_description/bindings/product_description_binding.dart';
import '../modules/product_description/views/product_description_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/rent_page/bindings/rent_page_binding.dart';
import '../modules/rent_page/views/rent_page_view.dart';
import '../modules/rental_delivery/bindings/rental_delivery_binding.dart';
import '../modules/rental_delivery/views/rental_delivery_view.dart';
import '../modules/rental_product_description/bindings/rental_product_description_binding.dart';
import '../modules/rental_product_description/views/rental_product_description_view.dart';
import '../modules/sell_page/bindings/sell_page_binding.dart';
import '../modules/sell_page/views/sell_page_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.BUY_PAGE,
      page: () => const BuyPageView(),
      binding: BuyPageBinding(),
    ),
    GetPage(
      name: _Paths.SELL_PAGE,
      page: () => const SellPageView(),
      binding: SellPageBinding(),
    ),
    GetPage(
      name: _Paths.RENT_PAGE,
      page: () => const RentPageView(),
      binding: RentPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.DRAFT,
      page: () => const DraftView(),
      binding: DraftBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DESCRIPTION,
      page: () => const ProductDescriptionView(),
      binding: ProductDescriptionBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS_PAGE,
      page: () => const OrdersPageView(),
      binding: OrdersPageBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS_DELIVERY,
      page: () => const OrdersDeliveryView(),
      binding: OrdersDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.RENTAL_PRODUCT_DESCRIPTION,
      page: () => const RentalProductDescriptionView(),
      binding: RentalProductDescriptionBinding(),
    ),
    GetPage(
      name: _Paths.RENTAL_DELIVERY,
      page: () => const RentalDeliveryView(),
      binding: RentalDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_RENTINGS,
      page: () => const ActiveRentingsView(),
      binding: ActiveRentingsBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
  ];
}
