import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/home/image_model.dart';
import 'package:myphsar/home/top_seller/top_seller_model.dart';

import '../product/product_model.dart';
import 'brand/all_brand_model.dart';
import 'daily_deal/daily_deal_model.dart';
import 'flash_deal/flash_deal_model.dart';

class HomeController extends BaseController {
  final BaseProvider _baseProvider;

  HomeController(this._baseProvider);

  int count = -1;
  var total = 0.obs;

  late Duration _duration;
  var day = 0.obs;
  var min = 0.obs;
  var hours = 0.obs;
  var sec = 0.obs;
  var cartCount = 0.obs;

  Duration get duration => _duration;

  final _flashDealModel = FlashDealModel().obs;

  final _allBrandModel = <AllBrandModel>[].obs;
  final _topSellerModel = <TopSellerModel>[].obs;
  final _flashDealList = <Products>[].obs;
  final _randomProductList = <Products>[].obs;

  final _recommendProductList = <Products>[].obs;
  final _dailyDealProductList = <Products>[].obs;
  final _topSellerProductImg = <ProductsImage>[].obs;

  // var _tModel = <TopModel>[].obs;

  List<AllBrandModel> get getAllBrandModel => _allBrandModel;

  // List<TopModel> get getTopModel => _tModel;

  List<ProductsImage> get getTopSellerProduct => _topSellerProductImg;

  FlashDealModel get getFlashDealModel => _flashDealModel.value;

  List<Products> get getRandomProductList => _randomProductList;

  List<Products> get getRecommendProductList => _recommendProductList;

  List<TopSellerModel> get getTopSellerModel => _topSellerModel;

  List<Products> get getFlashDealListModel => _flashDealList;

  List<Products> get getDailyDealProductListModel => _dailyDealProductList;

  void clearAllData() async {
    _allBrandModel.clear();
    _topSellerModel.clear();
    _flashDealList.clear();
    _randomProductList.clear();
    _recommendProductList.clear();
    _dailyDealProductList.clear();
    _topSellerProductImg.clear();
  }

  Timer? _timer;

  Future getFlashDeal() async {
    if (_timer != null) {
      _timer!.cancel();
    }
    DateTime endTime;
    await _baseProvider.getFlashDealApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _flashDealModel.value = FlashDealModel.fromJson(value.body),
              if (_flashDealModel.value.id != null)
                {
                  endTime = DateFormat("yyyy-MM-dd").parse(_flashDealModel.value.endDate.toString()),
                  _duration = endTime.difference(DateTime.now()),
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    _timer = timer;
                    if (DateTime.now().isAfter(endTime)) {
                      timer.cancel();
                    }
                    _duration = _duration - const Duration(seconds: 1);
                    day.value = _duration.inDays;
                    hours.value = _duration.inHours.remainder(24);
                    min.value = _duration.inMinutes.remainder(60);
                    sec.value = _duration.inSeconds.remainder(60);
                  }),
                  _baseProvider
                      .getFlashDealProductListApiProvider(FlashDealModel.fromJson(value.body).id.toString())
                      .then((value) => {
                            if (value.statusCode == 200)
                              {
                                _flashDealList.obs.value
                                    .addAll(ProductModel.fromJsonList(value.body).products!.toList()),
                              }
                            else
                              {}
                          })
                }
            }
        });
  }

  Future getRandomLatestProduct(int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }

    await _baseProvider.getRandomLatestProductApiProvider(offset.toString()).then((value) => {


          if (value.statusCode == 200)
            {
              _randomProductList.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
              notifySuccessResponse(_randomProductList.length)
            }
          else
            {
              infiniteLoading.value = false,
              if (offset ==1)
                {
                  change(false, status: RxStatus.error(value.statusCode.toString())),
                }
              //	notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())
            }
        });
  }

  Future getTopSeller() async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getTopSellerApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((value) =>
                  {_topSellerModel.add(TopSellerModel.fromJson(value)), notifySuccessResponse(_topSellerModel.length)}),
            }
          else
            {notifyErrorResponse("Error Code=${value.statusCode} \n${value.statusText}")}
        });
  }

  Future getAllBrands() async {
    await _baseProvider.getAllBrandsApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((value) => {_allBrandModel.add(AllBrandModel.fromJson(value))}),
            }
          else
            {}
        });
  }

  Future getRecommendProduct(int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }
    await _baseProvider.getRecommendApiProvider(offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              _recommendProductList.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
              notifySuccessResponse(_recommendProductList.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }

  Future getDailyDealProduct() async {
    _dailyDealProductList.clear();
    change(true, status: RxStatus.loading());
    try {
      await _baseProvider.getDailyDealApiProvider().then((value) => {
            if (value.statusCode == 200)
              {
                value.body.forEach((product) => {_dailyDealProductList.add(DailyDealModel.fromJson(product).product!)}),
                notifySuccessResponse(_dailyDealProductList.length)
              }
            else
              {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
          });
    } catch (e) {}
  }
}
