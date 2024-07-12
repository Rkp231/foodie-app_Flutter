import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/order.strings.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/repositories/order.repository.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:foodie/widgets/order/order_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderViewModel extends ViewModel {
  //
  OrderViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //repository
  OrderRepository ordersRepository = OrderRepository();
  int queryPage = 1;
  List<Order> orders = [];

  //
  RefreshController refreshController = RefreshController();

  //
  initialise() {
    fetchOrders();
  }

  void fetchOrders({
    bool initialLoading = true,
  }) async {
    if (initialLoading) {
      queryPage = 1;
      refreshController.resetNoData();
      setBusy(true);
    } else {
      queryPage++;
    }

    try {
      final mOrders = await ordersRepository.myOrders(
        page: queryPage,
      );

      if (initialLoading) {
        orders = mOrders;
      } else {
        orders.addAll(mOrders);
      }

      if (mOrders.length == 0) {
        print("No More data");
        refreshController.loadNoData();
      } else {
        refreshController.refreshCompleted();
      }
    } catch (error) {
      print("Orders error ==> $error");
      setErrorForObject(orders, error);
    }

    setBusy(false);
  }

  //
  //show more info about the order
  void showOrderInfo(Order selectedOrder) {
    //show a bottomsheet of the order info
    CustomDialog.showCustomBottomSheet(
      viewContext,
      content: OrderInfo(
        order: selectedOrder,
        onCancelledPressed: () => cancelOrder(selectedOrder),
      ),
    );
  }

  //
  //method called when user tap on cancel order button
  void cancelOrder(Order order) {
    //close the order details dialog
    CustomDialog.dismissDialog(viewContext);
    //show confirmation dialog
    final dialogData = DialogData();
    dialogData.title = OrderStrings.cancelOrderTitle;
    dialogData.body = OrderStrings.cancelOrderBody;
    dialogData.negativeButtonTitle = GeneralStrings.no;
    dialogData.positiveButtonTitle = GeneralStrings.yes;
    dialogData.dialogType = DialogType.warning;

    CustomDialog.showConfirmationActionAlertDialog(
      viewContext,
      dialogData,
      negativeButtonAction: () {
        viewContext.pop();
      },
      positiveButtonAction: () {
        viewContext.pop();
        processOrderCancellation(order);
      },
    );
  }

  //
  void processOrderCancellation(Order order) async {
    // setting the dialog data
    var dialogData = DialogData();
    dialogData.title = OrderStrings.cancelOrderTitle;
    dialogData.body = GeneralStrings.pleaseWait;
    dialogData.dialogType = DialogType.loading;
    dialogData.isDismissible = false;
    // show loading dialog
    showDialogAlert(dialogData: dialogData, onPositivePressed: () {});

    //process the order cancellation
    dialogData = await ordersRepository.cancelOrder(
      orderId: order.id,
    );

    //refresh the order list if operation is successful
    if (dialogData.dialogType == DialogType.success) {
      fetchOrders();
    }
    // close loading dialog
    viewContext.pop();

    // show dialog from the cancel order result
    showDialogAlert(dialogData: dialogData, onPositivePressed: () {});
  }
}
