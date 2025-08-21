import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import '../../app_constants.dart';
import 'banner_model.dart';

class BannerViewController extends BaseController {
  final BaseProvider _baseProvider;

  BannerViewController(this._baseProvider);

  final _mainBannerModel = BannerModel().obs;
  final _footerBannerModel = BannerModel().obs;

  BannerModel get getMainBannerModel => _mainBannerModel.value;

  BannerModel get getFooterBannerModel => _footerBannerModel.value;

  Future getMainBanner({bool firstLoad = false}) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getBannerApiProvider(AppConstants.MAIN_BANNER).then((value) => {
          if (value.statusCode == 200)
            {
              _mainBannerModel.value = BannerModel.getList(value.body),
              notifySuccessResponse(_mainBannerModel.value.bannerModelList!.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }

  Future getFooterBanner({bool firstLoad = false}) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getBannerApiProvider(AppConstants.FOOTER_BANNER).then((value) => {
          if (value.statusCode == 200)
            {
              _footerBannerModel.value = BannerModel.getList(value.body),
              notifySuccessResponse(_footerBannerModel.value.bannerModelList!.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }
}
