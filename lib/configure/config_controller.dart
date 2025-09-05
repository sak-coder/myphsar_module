import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/configure/config_model.dart';

class ConfigController extends BaseController {
  final BaseProvider baseProvider;

  ConfigController(this.baseProvider);

  ConfigModel _configModel = ConfigModel();

  ConfigModel get configModel => _configModel;

  RxString appVersion = 'app'.obs;
  RxInt versionCode = 0.obs;

  String get getAppVersion => appVersion.value;

  int get getAppVersionCode => versionCode.value;

  // Check with api response
  final String _baseShopBannerUrl = "https://myphsar.com/storage/shop/banner/";

  String get baseShopBannerUrl => _baseShopBannerUrl;

  CurrencyList _myCurrency = CurrencyList();

  final _currencyIndex = 0.obs;

  CurrencyList get myCurrency => _myCurrency;

  Future getConfigModel() async {
    change(true, status: RxStatus.loading());
    await baseProvider.getConfig().then((value) => {
          if (value.statusCode == 200)
            {_configModel = ConfigModel.fromJson(value.body), getCurrencyData("USD"), notifySuccessResponse(1)}
          else
            {
              notifyErrorResponse("Code: ${value.statusCode}\n${value.statusText}"),
            }
        });
  }

  Future getCurrencyData(String currencyCode) async {
    _configModel.currencyList?.forEach((currency) {
      if (currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex.value = _configModel.currencyList!.indexOf(currency);
        return;
      }
    });
  }

}
