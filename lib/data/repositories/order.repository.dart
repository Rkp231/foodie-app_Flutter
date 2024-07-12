import 'package:flutter/foundation.dart';
import 'package:foodie/constants/api.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/data/models/api_response.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/services/http.service.dart';
import 'package:foodie/utils/api_response.utils.dart';

class OrderRepository extends HttpService {
  //get my orders from server
  Future<List<Order>> myOrders({
    int page = 1,
  }) async {
    List<Order> orders = [];

    //make http call for vendors data
    final apiResult = await get(Api.orders, queryParameters: {
      "page": page.toString(),
    });

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //convert the data to list of delivery address model
    (apiResponse.body["data"] as List).forEach((orderJSONObject) {
      orders.add(Order.fromJSON(
        jsonObject: orderJSONObject,
      ));
    });
    return orders;
  }

  Future<DialogData> cancelOrder({
    @required int orderId,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    //make http call for vendors data
    final apiResult = await patch(
      "${Api.orders}/${orderId}",
      {
        "status": "cancelled",
      },
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = GeneralStrings.successfulTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;
      resultDialogData.isDismissible = true;
    } else {
      resultDialogData.title = GeneralStrings.failedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
      resultDialogData.isDismissible = true;
    }

    return resultDialogData;
  }
}
