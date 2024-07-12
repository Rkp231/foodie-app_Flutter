import 'package:foodie/constants/api.dart';
import 'package:foodie/data/models/api_response.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/services/http.service.dart';
import 'package:foodie/utils/api_response.utils.dart';

class ProductRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<Product>> getProducts({
    String keyword = "",
  }) async {
    List<Product> products = [];

    //make http call for vendors data
    final apiResult = await get(
      Api.searchProducts,
      queryParameters: {
        "keyword": keyword,
      },
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
    (apiResponse.body["products"] as List).forEach((vendorJSONObject) {
      //vendor data
      final mProduct = Product.fromJSON(
        jsonObject: vendorJSONObject,
        withExtras: true,
      );

      mProduct.currency = defultCurrency;
      products.add(mProduct);
    });

    return products;
  }
}
