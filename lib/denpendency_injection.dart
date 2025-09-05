import 'package:get/get.dart';
import 'package:myphsar/aba_pay/aba_pay_view_controller.dart';
import 'package:myphsar/account/support/support_ticket_controller.dart';
import 'package:myphsar/account/wishlist/wishlist_controller.dart';
import 'package:myphsar/auth/AuthController.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/category/category_controller.dart';
import 'package:myphsar/ccu/ccu_controller.dart';
import 'package:myphsar/configure/config_controller.dart';
import 'package:myphsar/dashborad/dash_board_controller.dart';
import 'package:myphsar/helper/share_pref_controller.dart';
import 'package:myphsar/helper/share_pref_provider.dart';
import 'package:myphsar/installment/installment_view_controller.dart';
import 'package:myphsar/new_arrival/new_arrival_view_controller.dart';
import 'package:myphsar/order/order_history_view_controller.dart';
import 'package:myphsar/product_detail/product_detail_controller.dart';
import 'package:myphsar/review/review_item_controller.dart';
import 'package:myphsar/reviews/review_view_controller.dart';
import 'package:myphsar/shop_profile/shop_profile_controller.dart';
import 'package:myphsar/top_selling/top_selling_view_controller.dart';
import 'package:myphsar/track_order/tracking_order_view_controller.dart';
import 'package:myphsar/vtc_pay/vattnac_pay_view_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account/address/address_view_controller.dart';
import 'account/installments_history/InstallmentHistoryViewController.dart';
import 'account/installments_history_detail/InstHistoryDetailViewController.dart';
import 'account/user_profile/user_profile_controller.dart';
import 'cart/cart_controller.dart';
import 'category/category_detail/category_detail_controller.dart';
import 'chat/chat_controller.dart';
import 'check_out/check_out_controller.dart';
import 'home/banner/banner_view_controller.dart';
import 'home/daily_deal/daily_deal_controller.dart';
import 'home/home_controller.dart';
import 'home/recommend/recommend_controller.dart';
import 'home/search/search_view_controller.dart';
import 'home/seller/seller_controller.dart';
import 'home/top_seller/top_seller_controller.dart';
import 'installment_product/installment_product_view_controller.dart';
import 'notification/notification_controller.dart';


class DependencyBinding implements Bindings {
  final String baseUrl;

  DependencyBinding(this.baseUrl);

  @override
  Future<void> dependencies() async {
    final getInstance = GetInstance();
    final prf = await SharedPreferences.getInstance();
    getInstance.lazyPut(() => BaseProvider(baseUrl), fenix: true);
    getInstance.put(prf);
    getInstance.lazyPut(() => AuthController(getInstance()), permanent: true);
    getInstance.lazyPut(() => BaseController(), fenix: true);
    getInstance.lazyPut(() => SharePrefController(getInstance()), fenix: true); // fenix is keep ref in memory
    getInstance.lazyPut(() => SharePrefProvider(getInstance()));
    getInstance.lazyPut(() => HomeController(getInstance()), fenix: true);
    getInstance.lazyPut(() => DashBoardController(), permanent: true);
    getInstance.lazyPut(() => ConfigController(getInstance()), fenix: true);
    getInstance.lazyPut(() => ShopProfileController(getInstance()), permanent: true);
    getInstance.lazyPut(() => CategoryController(getInstance()), fenix: true);
    getInstance.lazyPut(() => CategoryDetailController(getInstance()), fenix: true);
    getInstance.lazyPut(() => RecommendController(getInstance()), fenix: true);
    getInstance.lazyPut(() => TopSellerController(getInstance()), fenix: true);
    getInstance.lazyPut(() => DailyDealController(getInstance()), fenix: true);
    getInstance.lazyPut(() => SearchViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => ProductDetailController(getInstance()), fenix: true);
    getInstance.lazyPut(() => ReviewItemController(getInstance()), permanent: true);
    getInstance.lazyPut(() => UserProfileController(getInstance()), fenix: true);
    getInstance.lazyPut(() => AddressViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => WishlistController(getInstance()), fenix: true);
    getInstance.lazyPut(() => SupportTicketController(getInstance()), fenix: true);
    getInstance.lazyPut(() => NotificationController(getInstance()), fenix: true);
    getInstance.lazyPut(() => ChatController(getInstance()), fenix: true);
    getInstance.lazyPut(() => SellerController(getInstance()), fenix: true);
    getInstance.lazyPut(() => CartController(getInstance()), fenix: true);
    getInstance.lazyPut(() => CheckOutController(getInstance()), fenix: true);
    getInstance.lazyPut(() => OrderHistoryViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => TrackingOrderViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => ReviewViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => NewArrivalViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => TopSellingViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => AbaPayViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => InstallmentViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => InstallmentHistoryViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => InstHistoryDetailViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => InstallmentProductViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => BannerViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => VattanacPayViewController(getInstance()), fenix: true);
    getInstance.lazyPut(() => CcuController(getInstance()), fenix: true);
  }
}
//	getInstance.create<ConfigController>(() => ConfigController(configProvider:getInstance()));
