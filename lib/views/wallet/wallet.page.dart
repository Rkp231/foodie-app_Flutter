import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/strings/profile/profile.strings.dart';
import 'package:foodie/constants/strings/wallet.strings.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/wallet.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/state/busy_indicator.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with WidgetsBindingObserver {
  //
  WalletViewModel walletViewModel = WalletViewModel();

  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      print("went to Background");
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      walletViewModel.fetchWallet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => walletViewModel,
      onModelReady: (vm) => vm.initialize(context),
      builder: (context, vm, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: ProfileStrings.wallet,
          body: VStack(
            [
              //
              vm.isBusy
                  ? BusyIndicator().centered()
                  : vm.hasError
                      ? LoadingStateDataView(
                          stateDataModel: StateDataModel(
                            actionButtonStyle:
                                context.textTheme.bodyText1.copyWith(
                              color: Colors.red,
                            ),
                            showActionButton: true,
                            actionFunction: vm.fetchWallet,
                          ),
                        )
                      : VxBox(
                          child: VStack([
                            //balance
                            WalletStrings.balance.text.sm.make(),
                            HStack(
                              [
                                //currency
                                vm.currency.symbol.text.medium.xl2.make(),
                                //amount
                                vm.wallet.balance.numCurrency.text.semiBold.xl3
                                    .make()
                                    .px2(),
                              ],
                            ).pOnly(bottom: Vx.dp14),

                            //last updated time
                            WalletStrings.updatedAt.text.sm.make(),
                            vm.wallet.formattedUpdatedAt.text.medium.xl.make(),
                          ]).wFull(context).p20(),
                        ).roundedSM.color(context.cardColor).shadow.make(),

              //top-up button
              vm.isBusy || vm.hasError
                  ? UiSpacer.empty()
                  : CustomButton(
                      child: HStack(
                        [
                          //
                          Icon(
                            FlutterIcons.plus_fea,
                          ),
                          //
                          UiSpacer.horizontalSpace(space: 5),
                          //
                          WalletStrings.topUp.text.xl.make(),
                        ],
                      ),
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      loading: vm.busy(vm.wallet),
                      onPressed: vm.topUpWallet,
                    ).wFull(context).py12(),
            ],
          ).scrollVertical().p20(),
        );
      },
    );
  }
}
