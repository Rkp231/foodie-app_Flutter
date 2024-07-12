import 'package:foodie/constants/api.dart';
import 'package:foodie/data/models/api_response.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/services/http.service.dart';
import 'package:foodie/utils/api_response.utils.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

enum VendorListType {
  all,
  newest,
  popular,
  nearBy,
}

class VendorRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<Vendor>> getVendors({
    VendorListType type = VendorListType.all,
    String keyword = "",
    int categoryId,
    LocationData location = null,
  }) async {
    List<Vendor> vendors = [];

    final requestBody = {
      "type": type.toString(),
      "keyword": keyword,
      "category_id": categoryId,
    };

    if (location != null) {
      requestBody["latitude"] = location.latitude;
      requestBody["longitude"] = location.longitude;
    }

    //make http call for vendors data
    final apiResult = await get(
      Api.vendors,
      queryParameters: requestBody,
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //currency
    final defultCurrency = Currency.fromJson(
      currencyJSONObject: apiResponse.body["currency"],
    );

    //save the newly gotten currency to database
    await appDatabase.currencyDao.deleteAll();
    await appDatabase.currencyDao.insertItem(defultCurrency);

    //convert the data to list of vendor model
    (apiResponse.body["vendors"] as List).forEach((vendorJSONObject) {
      //vendor data
      final mVendor = Vendor.fromJSON(
        jsonObject: vendorJSONObject,
        withExtras: false,
      );

      mVendor.currency = defultCurrency;
      vendors.add(mVendor);
    });

    return vendors;
  }

  //get vendor details from server base on the type
  Future<Vendor> getVendorDetails({int vendorId}) async {
    //make http call for vendors data
    final apiResult = await get(
      "${Api.vendors}/$vendorId",
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    final vendor = Vendor.fromJSON(jsonObject: apiResponse.body);
    final currencies = await appDatabase.currencyDao.findAllCurrencys();
    vendor.currency = currencies[0];
    return vendor;
  }
}
