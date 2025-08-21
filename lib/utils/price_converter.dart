import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/configure/config_controller.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price,
      {required double discount, required String discountType}) {
    if (discountType == 'amount' || discountType == AppConstants.DISCOUNT_FLAT) {
      price = price - discount;
    } else if (discountType == AppConstants.DISCOUNT_PERCENT || discountType == 'percentage') {
      price = price - ((discount / 100) * price);
    }

    return currencySignAlignment(price);
  }

  static String currencySignAlignment(double price) {
    bool singleCurrency = Get.find<ConfigController>().configModel.currencyModel == 'single_currency';
    bool inRight = Get.find<ConfigController>().configModel.currencySymbolPosition == 'right';
    var exchangeRate = Get.find<ConfigController>().myCurrency.exchangeRate;
    return '${inRight ? '' : Get.find<ConfigController>().myCurrency.symbol}${(singleCurrency ? price : price * exchangeRate! * (1 / exchangeRate)).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${inRight ? Get.find<ConfigController>().myCurrency.symbol : ''}';
  }

  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if (discountType == 'amount' || discountType == AppConstants.DISCOUNT_FLAT) {
      price = price - discount;
    } else if (discountType == AppConstants.DISCOUNT_PERCENT || discountType == 'percentage') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == AppConstants.DISCOUNT_FLAT) {
      calculatedAmount = discount * quantity;
    } else if (type == AppConstants.DISCOUNT_PERCENT || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, double price, double discount, String discountType) {
    return (discountType == AppConstants.DISCOUNT_PERCENT || discountType == 'percentage') ? '$discount%' : '$discount\$ OFF';
  }
}
