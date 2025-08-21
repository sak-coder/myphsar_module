import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/notification/notification_model.dart';

class NotificationController extends BaseController {
  BaseProvider _baseProvider;

  NotificationController(this._baseProvider);

  var _notificationModel = <NotificationModel>[].obs;

  List<NotificationModel> get getAllNotificationModel => _notificationModel;

  Future getAllNotification(bool clearData) async {
    if (clearData) {
      _notificationModel.obs.value.clear();
    }
    change(true, status: RxStatus.loading());
    _baseProvider.getAllNotificationApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((val) => {
                    _notificationModel.obs.value.add(NotificationModel.fromJson(val)),
                    notifySuccessResponse(_notificationModel.length)
                  })
            }
          else
            {notifyErrorResponse("Error Code: " + value.statusCode.toString() + "\n" + value.statusText.toString())}
        });
  }
}
