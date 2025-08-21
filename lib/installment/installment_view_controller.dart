import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/installment/job_model.dart';
import 'package:myphsar/installment/submit_installment_body.dart';
import 'package:myphsar/installment/available_lender_model.dart';
import 'package:myphsar/installment/duration_model.dart';
import 'package:myphsar/installment/payment_table/payment_table_model.dart';

import '../check_out/available_online_payment_model.dart';
import 'province_city_model.dart';
import 'checkout/installment_check_out_detail_model.dart';

class InstallmentViewController extends BaseController {
  final BaseProvider _baseProvider;

  InstallmentViewController(this._baseProvider);

  final _jobModel = <JobData>[].obs;
  final _provinceCityModel = <CityData>[].obs;
  final _durationModel = <DurationData>[].obs;
  final _submitInstallmentsBody = SubmitInstallmentBody().obs;
  final _capturePhotoPath = "".obs;
  final _selfieCapturePhotoPath = "".obs;
  final _lenderListModel = <AvailableLenderData>[].obs;
  final _paymentTable = PaymentTableModel().obs;
  final _installmentCheckOutModel = InstallmentCheckoutDetailModel().obs;
  final _productImage = ''.obs;

  final RxBool _loading = false.obs;

  bool get getLoading => _loading.value;
  final _paymentMethods = <PaymentMethods>[].obs;

  List<PaymentMethods> get getAvailableOnlinePaymentModel => _paymentMethods;

  void showLoader() async {
    _loading.value = true;
  }

  void stopLoader() async {
    _loading.value = false;
  }

  RxBool showLoading = false.obs;

  // String get getUuid => _uuid.value;
  String get getInstallmentProductImg => _productImage.value;

  String get getFrontCapturePhotoPath => _capturePhotoPath.value;

  String get getSelfieCapturePhotoPath => _selfieCapturePhotoPath.value;

  InstallmentCheckoutDetailModel get getInstallmentCheckOutModel => _installmentCheckOutModel.value;

  SubmitInstallmentBody get getSubmitInstallmentBody => _submitInstallmentsBody.value;

  PaymentTableModel get getPaymentTableModel => _paymentTable.value;

  List<AvailableLenderData> get getAvailableLenderList => _lenderListModel;

  List<JobData> get getJobModelList => _jobModel;

  List<CityData> get getProvinceCityModelList => _provinceCityModel;

  List<DurationData> get getDurationModelList => _durationModel;

  void saveCapturePhotoFile(XFile xFile) {
    _capturePhotoPath.value = xFile.path;
  }

  void saveSelfieCapturePhotoFile(XFile xFile) {
    _selfieCapturePhotoPath.value = xFile.path;
  }

  // check with api to response image attr
  void addProductImg(String img, {bool reset = false}) {
    if (reset) {
      _productImage.value = '';
    }
    _productImage.value = img;
  }

  void resetPickData() {
    _provinceCityModel.clear();
    _jobModel.clear();
    _durationModel.clear();
  }

  void resetData() {
    _capturePhotoPath.value = "";
    _selfieCapturePhotoPath.value = "";
    showLoading.value = false;
  }

  Future getInstallmentInfoData() async {
    resetPickData();
    change(true, status: RxStatus.loading());
    await _baseProvider.getCityApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _provinceCityModel.obs.value.addAll(ProvinceCityModel.fromJson(value.body).data!.toList()),
            }
          else
            {change(true, status: RxStatus.error())}
        });
    await _baseProvider.getJobTypeApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _jobModel.obs.value.addAll(JobModel.fromJson(value.body).data!.toList()),
            }
          else
            {change(true, status: RxStatus.error())}
        });
    await _baseProvider.getInstallmentTermApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _durationModel.obs.value.addAll(DurationModel.fromJson(value.body).data!.toList()),
              change(true, status: RxStatus.success())
            }
          else
            {
              change(true,
                  status: RxStatus.error("Error Code: ${value.statusCode} \n Error Message: ${value.statusText}"))
            }
        });
  }

  Future submitInstallments(BuildContext context, SubmitInstallmentBody submitInstallmentBody, File frontImage,
      File selfie, Function(String) callback) async {
    var uuid = '';
    if(showLoading.value) {
      return ;
    };

    showLoading.value = true;
    await _baseProvider.submitInstallmentForm(submitInstallmentBody, frontImage, selfie).then((value) async => {
          if (value.statusCode == 200)
            {
              uuid = jsonDecode(await value.stream.bytesToString())['data']['uuid'],
              await _baseProvider.getAvailableLenderApiProvider(uuid).then((value) => {
                    if (value.statusCode == 200)
                      {
                        showLoading.value = false,
                        callback(uuid),
                        _lenderListModel.obs.value.clear(),
                        _lenderListModel.obs.value.addAll(AvailableLenderModel.fromJson(value.body).data!.toList()),
                      }
                    else
                      {
                        //TODO: context warning
                        showLoading.value = false,
                        snackBarMessage(context, "Error Code: ${value.statusCode} \n${'submit_field'.tr}")
                      }
                  })
            }
          else
            {
              showLoading.value = false,
              snackBarMessage(context, "Error Code: ${value.statusCode} \n${'submit_field'.tr}")
            }
        });
  }

  Future submitSelectedLender(String uuid, String lenderId) async {
    await _baseProvider.submitSelectedLenderApiProvider(uuid, lenderId).then((value) async => {
          if (value.statusCode == 200)
            {
              await _baseProvider.getCalculationTableApiProvider(uuid).then((value) => {
                    if (value.statusCode == 200)
                      {
                        _paymentTable.value = PaymentTableModel.fromJson(value.body),
                      }
                    else
                      {}
                  })
            }
          else
            {}
        });
  }

  Future getInstallmentsCalculationTable(String uuid) async {
    _baseProvider.getCalculationTableApiProvider(uuid).then((value) => {
          if (value.statusCode == 200)
            {change(true, status: RxStatus.success()), _paymentTable.value == PaymentTableModel.fromJson(value.body)}
          else
            {change(true, status: RxStatus.error("error_msg".tr))}
        });
  }

  Future getAvailableInstallmentOnlinePayment(String lenderId) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getAvailableInstallmentsOnlinePaymentProvider(lenderId).then((value) => {
          if (value.statusCode == 200)
            {
              _loading.value = false,
              _paymentMethods.value = AvailableOnlinePaymentModel.fromJson(value.body).paymentMethods!,
              notifySuccessResponse(_paymentMethods.length)
            }
          else
            {
              _loading.value = false,
              notifyErrorResponse("Error Code=${value.statusCode} \n${value.statusText}")
            }
        });
  }

  Future getInstallmentCheckOutDetail(String uuid) async {
    print("F>>uuid =  "+ uuid.toString());
    await _baseProvider.getInstallmentCheckOutDetailApiProvider(uuid).then((value) => {
          if (value.statusCode == 200)
            {

              print("F>>ddd =  "+ value.body.toString()),
              _installmentCheckOutModel.value = InstallmentCheckoutDetailModel.fromJson(value.body),
            }
        });
  }

  Future getInstallmentTransactionStatus({required String tid, required Function(bool) callback}) async {
    showLoader();
    await _baseProvider.checkInstallmentsTransactionApiProvider(tid).then((value) => {
          if (value.statusCode == 200)
            {
              if (value.body['status'] == true)
                {
                  callback(true),
                }
              else
                {
                  callback(false),
                }
            }
          else
            {
              callback(false),
            }
        });
  }

  Future installmentCheckOut(String url, Function(bool) callback) async {
    await _baseProvider.installmentsPlaceOrder(url).then((value) => {
          if (value.statusCode == 200)
            {
              callback(true),
            }
          else
            {callback(false)}
        });
  }
}
