class AppConstants {
  static const String APP_NAME = 'MyPhsar';

  static const PRO_BASE_URL = 'https://myphsar.com';
  static const DEV_BASE_URL = 'https://dev.myphsar.com';
  static const String BASE_PAY_LATER_URL = 'https://api-paylater.myphsar.com';
  static const String BASE_VTC_URL = 'https://sandbox-pay.vattanacbank.com';

  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static const String CATEGORIES_URI = '/api/v1/categories';
  static const String BRANDS_URI = '/api/v1/brands';
  static const String BRAND_PRODUCT_URI = '/api/v1/brands/products/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String NEW_ARRIVAL_PRODUCTS_URI = '/api/v1/products/latest?limit=20&&offset=';
  static const String RANDOM_PRODUCTS_URI = '/api/v1/products/latest?random&&limit=30&&offset=';
  static const String TOP_PRODUCTS_URI = '/api/v1/products/top-rated?limit=20&&offset=';
  static const String BEST_SELLING_PRODUCTS_URI = '/api/v1/products/best-sellings?limit=20&offset=';
  static const String FEATURED_PRODUCTS_URI = '/api/v1/products/featured?limit=20&&offset=';

// static const String HOME_CATEGORY_PRODUCTS_URI = '/api/v1/products/home-categories?limit=30&&offset=';

  static const String HOME_CATEGORY_PRODUCTS_URI = '/api/v1/products/home-categories-v2?limit=30&offset=';

  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String PRODUCT_REVIEW_URI = '/api/v1/products/reviews/';

  // static   String SEARCH_URI = '/api/v1/products/search?name=${'macbook'}&&limit=10&&offset=';


  static   String SEARCH_RECOMMEND_URI = '/api/v1/products/get-recommended-search?name=';

  static const String CONFIG_URI = '/api/v1/config';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?product_id=';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String CUSTOMER_URI = '/api/v1/customer/info';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String SUPPORT_TICKET_URI = '/api/v1/customer/support-ticket/create';
  static const String MAIN_BANNER_URI = '/api/v1/banners?banner_type=';
  static const String FOOTER_BANNER_URI = '/api/v1/banners?banner_type=';
  static const String RELATED_PRODUCT_URI = '/api/v1/products/related-products/';
  static const String ORDER_URI = '/api/v1/customer/order/list';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String ORDER_PLACE_URI = '/api/v1/customer/order/place';
  static const String SELLER_URI = '/api/v1/seller?seller_id=';
  static const String SELLER_PRODUCT_URI = '/api/v1/seller/';
  static const String TOP_SELLER = '/api/v1/seller/top';
  static const String ALL_SELLER = '/api/v1/seller/all';
  static const String AVAILABLE_INSTALLMENT_ONLINE_PAYMENT = '/api/v1/online-installment-payment/available-payment/';
  static const String AVAILABLE_ONLINE_PAYMENT = '/api/v1/online-payment/available-payment';

//ABA
  static const String ABA_PAY_URI = '/api/v1/cart/payment-methods';
  static const String ABA_PAY_STATUS_URI = '/api/v1/payway-complete';

  //Vattnac

  static const String AVAILABLE_ONLINE_INSTALLMENT_PAY_URI = '/api/v1/online-installment-payment/available-payment/';
  static const String AVAILABLE_ONLINE_PAY_HASH = '/api/v1/online-payment/available-payment/';

  static const String CHECK_INSTALLMENTS_TRANSACTION_URI = "/api/v1/online-installment-payment/check-transaction/";
  static const String CHECK_TRANSACTION_URI = '/api/v1/vattanac-bank/check-transactions';

  static const String TRACKING_URI = '/api/v1/order/track?order_id=';
  static const String CE_TRACKING_URI = '/api/v1/ce-express/tracking-order/';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String SUPPORT_TICKET_GET_URI = '/api/v1/customer/support-ticket/get';
  static const String SUPPORT_TICKET_CONV_URI = '/api/v1/customer/support-ticket/conv/';
  static const String SUPPORT_TICKET_REPLY_URI = '/api/v1/customer/support-ticket/reply/';
  static const String SUBMIT_REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String FLASH_DEAL_URI = '/api/v1/flash-deals';
  static const String FEATURED_DEAL_URI = '/api/v1/deals/featured';
  static const String FLASH_DEAL_PRODUCT_URI = '/api/v1/flash-deals/products/';
  static const String COUNTER_URI = '/api/v1/products/counter/';
  static const String SOCIAL_LINK_URI = '/api/v1/products/social-share-link/';
  static const String SHIPPING_URI = '/api/v1/products/shipping-methods';
  static const String SHIPPING_URI_V1 = '/api/v1/products/shipping-methods?version=1';

  // static const String CHOSEN_SHIPPING_URI = '/api/v1/shipping-method/chosen';
  static const String COUPON_URI = '/api/v1/coupon/apply?code=';

  static const String READ_CHAT_URI = '/api/v1/customer/chat/message-heartbeat?shop_id=';
  static const String MESSAGES_URI = '/api/v1/customer/chat/messages?shop_id=';
  static const String CHAT_INFO_URI = '/api/v1/customer/chat';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/chat/send-message';

  static const String FIREBASE_TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String NOTIFICATION_URI = '/api/v1/notifications';

  static const String GET_CART_DATA_URI = '/api/v1/cart';
  static const String ADD_TO_CART_URI = '/api/v1/cart/add';
  static const String UPDATE_CART_QUANTITY_URI = '/api/v1/cart/update';
  static const String REMOVE_FROM_CART_URI = '/api/v1/cart/remove';
  static const String REMOVE_ALL_CART = '/api/v1/cart/remove-all';

  static const String GET_SHIPPING_METHOD = '/api/v1/shipping-method/by-seller';
  static const String CHOOSE_SHIPPING_METHOD = '/api/v1/shipping-method/choose-for-order';

  // static const String CHOSEN_SHIPPING_METHOD_URI = '/api/v1/shipping-method/chosen';
  static const String GET_SHIPPING_INFO = '/api/v1/shipping-method/detail/1';
  static const String CHECK_PHONE_URI = '/api/v1/auth/check-phone';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String SOCIAL_LOGIN_URI = '/api/v1/auth/social-login';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_OTP_URI = '/api/v1/auth/verify-otp';

//PayLater
  static const String LENDER_LIST_URI1 = '/api/v1/get-financial';
  static const String LENDER_LIST_URI = '/api/v1/get-install-financier-available';
  static const String INSTALLMENT_LIST_URI = '/api/v1/installment/account-installment';
  static const String INSTALLMENT_HISTORY_DETAIL_URI = '/api/v1/installment/account-installment/';
  static const String INSTALLMENT_TABLE_URI = '/api/v1/installment/get-installment-calculator/';
  static const String INSTALLMENT_CHECKOUT_DETAIL_URI = '/api/v1/installment/checkout/';

  static const String CITY_URI = '/api/v1/installment/cities';

  static const String JOB_TYPE_URI = '/api/v1/installment/job-types';
  static const String INSTALLMENTS_DURATION_URI = '/api/v1/installment/durations';
  static const String INSTALLMENTS_PRODUCT_URI = '/api/v1/products/installment?limit=20&&offset=';
  static const String AVAILABLE_LENDER_URI = "/api/v1/installment/get-available-financier/";
  static const String SUBMIT_INSTALLMENTS_URI = "/api/v1/installment/submit";
  static const String SUBMIT_CHECKOUT_INSTALLMENT_URI = "/api/v1/installment/checkout-submit/";
  static const String SELECT_FINANCIER_URI = "/api/v1/installment/select-financier";
  static const String LENDER_DETAIL_URI = "/api/v1/installment/financier/";

  //CE
  static const String CE_GET_AVAILABLE_CITY_URI = "/api/v1/cities";
  static const String CE_CHECK_DELIVERY_URI = "/api/v1/shipping-method/check-delivery-fee?";
  static const String CE_CHECK_SHIPPING_METHOD_URI = "/api/v1/shipping-method/check-delivery-fee?";
  static const String CE_CHECK_CHOSEN_SHIPPING_METHOD_URI = "/api/v1/shipping-method/chosen?";

//Customize

  static const String REMOVE_ACCOUNT_URI = '/api/v1/user/removal';

// sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String LANG_KEY = 'lang';
  static const String INTRO = 'intro';
  static const String SHIPPING_METHOD = 'shipping_method_key';
  static const String SEARCH_KEY = 'search_product_key';

// order status
  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'canceled';
  static const String OUT_FOR_DELIVERY = 'out_for_delivery';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';

  //static const String TOPIC = 'sixvalley';
  static const String TOPIC = 'myphsar';
  static const String CASH = 'cash_on_delivery';
  static const String VTC_BANK = 'Vattanac Bank';
  static const String CCU_BANK = 'CCU Bank';

  static const String DEFAULT_ADDRESS = 'default';

  static const String DISCOUNT_FLAT = "flat";
  static const String DISCOUNT_PERCENT = "percent";

  static const String MAIN_BANNER = "main_banner";
  static const String FOOTER_BANNER = "footer_banner";

  static const String VTN_PAY = 'vtnpay';
  static const String CARD_PAY = 'card';
  static const String ABA_PAY = 'abapay';
  static const String CCU_PAY = 'ccupay';

  static const int PAY_SUCCESS_CODE = 1;
  static const int INSTALLMENT_PAY_SUCCESS_CODE = 2;
  static const int PAY_FAILED_CODE = 0;

  //pay way
  static const String PAYWAY_CONPLETE = "/success-online-payment-mob";
  static const String INSTALLMENT_PAYWAY_CONPLETE = "/success-online-installment-payment-mob";

  static const String GOOGLE_LOGIN = 'google';
  static const String FB_LOGIN = 'facebook';
  static const String APPLE_LOGIN = 'apple';

//Telegram bot credentials5156832876138436934
// static const String TELEGRAM_ID = "@myphsar_order";
// static const String TELEGRAM_TOKEN = "5088480481:AAHg4HTTxL4NTqMcZ-ayGGHKN-2kE_h5eXY";
}
enum CompleteOrder { continueShopping, myOrder ,installments}
