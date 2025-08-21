import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/account/installments_history/InstallmentHistoryModel.dart';

class InstallmentHistoryViewController extends BaseController {
  final BaseProvider _baseProvider;

  InstallmentHistoryViewController(this._baseProvider);

  final _installmentHistoryList = InstallmentsHistoryModel().obs;

  InstallmentsHistoryModel get getInstallmentsHistoryListModel => _installmentHistoryList.value;

  Future getInstallmentHistory() async {
    change(false, status: RxStatus.loading());
    await _baseProvider.getInstallmentsHistoryApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _installmentHistoryList.value = InstallmentsHistoryModel.fromJson(value.body),
              notifySuccessResponse(_installmentHistoryList.value.data!.length)
            }
          else
            {
              notifyErrorResponse(value.statusText.toString())
            }
        });
  }
}
