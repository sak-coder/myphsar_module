import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/ccu/ccu_response_model.dart';

class CcuController extends BaseController {
  final BaseProvider baseProvider;

  CcuController(this.baseProvider);

  var _ccuResponseModel = CcuResponseModel();

  CcuResponseModel get getCcuResponseModel => _ccuResponseModel;

  Future getCcuPaymentModel(String paymentId, String currency, Function(String)? callback) async {
    change(true, status: RxStatus.loading());
    await baseProvider.getCcuPaymentHashProvider(id: paymentId, currency: currency).then((value) => {
          if (value.statusCode == 200)
            {

              _ccuResponseModel = CcuResponseModel.fromJson(value.body),
              callback!(_ccuResponseModel.formUrl.toString()),
              notifySuccessResponse(1)
            }
          else
            {
              notifyErrorResponse(value.statusText.toString()),
            }
        });
  }
}
