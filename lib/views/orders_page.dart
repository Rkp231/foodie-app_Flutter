import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/viewmodels/order.viewmodel.dart';
import 'package:foodie/widgets/empty/empty_orders.dart';
import 'package:foodie/widgets/listview/list_view_pull_up_footer.dart';
import 'package:foodie/widgets/order/order_item.dart';
import 'package:foodie/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:foodie/widgets/state/unauthenticated.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:foodie/translations/order.i18n.dart';


class OrdersPage extends StatefulWidget {
  OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin<OrdersPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder<OrderViewModel>.reactive(
      viewModelBuilder: () => OrderViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        //page body
        Widget pageBody;

        //checking if user is authenticated or not
        if (AuthBloc.authenticated()) {
          //

          pageBody = SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ListViewPullUpFooter(),
            controller: vm.refreshController,
            onRefresh: () => vm.fetchOrders(initialLoading: true),
            onLoading: () => vm.fetchOrders(initialLoading: false),
            child: vm.isBusy
                ? GeneralShimmerListViewItem()
                : vm.orders.isEmpty
                    ? EmptyOrders()
                    : ListView.separated(
                        padding: AppPaddings.defaultPadding(),
                        itemBuilder: (context, index) {
                          return OrderItem(
                            order: vm.orders[index],
                            onPressed: vm.showOrderInfo,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                        ),
                        itemCount: vm.orders.length,
                      ),
          );
        } else {
          pageBody = UnauthenticatedPage();
        }

        return Scaffold(
          backgroundColor: AppColor.appBackground(context),
          appBar: AppBar(
            backgroundColor: AppColor.appBackground(context),
            elevation: 0,
            title: Text(
              "My Orders".i18n,
              style: AppTextStyle.h1TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          body: pageBody,
        );
      },
    );
  }
}
