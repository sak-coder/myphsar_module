import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import 'InstallmentHistoryDetailModel.dart';

class InstHistoryDetailViewController extends BaseController {
  final BaseProvider _baseProvider;

  InstHistoryDetailViewController(this._baseProvider);

  final _instHistoryDetail = InstDetailData().obs;

  InstDetailData get getInstallmentHistoryDetail => _instHistoryDetail.value;

  Future getInstallmentsHistoryDetail(String uuid) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getInstallmentsHistoryDetailApiProvider(uuid).then((value) => {
          if (value.statusCode == 200)
            {
              _instHistoryDetail.value = InstallmentHistoryDetailModel.fromJson(value.body).data!,
              notifySuccessResponse(1)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }
}
