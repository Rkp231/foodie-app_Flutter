import 'package:flutter/src/widgets/framework.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/data/repositories/product.repository.dart';
import 'package:foodie/data/repositories/vendor.repository.dart';
import 'package:foodie/viewmodels/base.viewmodel.dart';

class SearchViewModel extends MyBaseViewModel {
  int queryCategoryId;
  //VendorRepository instance
  VendorRepository vendorRepository = VendorRepository();
  ProductRepository productRepository = ProductRepository();
  List<Vendor> vendors = [];
  List<Product> products = [];
  bool loadProduct = true;
  bool loadVendor = true;
  SearchViewModel(BuildContext context, int categoryId);

  void toggleLoadProduct(bool value) {
    loadProduct = value;
    notifyListeners();
  }

  void toggleLoadVendor(bool value) {
    loadVendor = value;
    notifyListeners();
  }

  //
  void initSearch(String value, {bool forceSearch = false}) async {
    //making sure user entered something before doing an api call
    if (value.isNotEmpty || forceSearch) {
      //add null data so listener can show shimmer widget to indicate loading
      vendors.clear();
      products.clear();
      setBusy(true);

      try {
        if (loadVendor) {
          vendors = await vendorRepository.getVendors(
            type: VendorListType.all,
            keyword: value,
            categoryId: queryCategoryId,
          );
        }

        if (loadProduct) {
          products = await productRepository.getProducts(
            keyword: value,
          );
        }
      } catch (error) {
        print("Error ==> $error");
        setError(error);
      }

      setBusy(false);
    }
  }
}
