import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/category_banner.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/viewmodels/banners.viewmodel.dart';
import 'package:foodie/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';

class BannerSlider extends StatefulWidget {
  final Function(CategoryBanner) onBannerTapped;
  BannerSlider({@required this.onBannerTapped, Key key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      onModelReady: (model) => model.fetchBanners(),
      builder: (context, model, child) {
        return model.isBusy
            ? Padding(
                padding: AppPaddings.defaultPadding(),
                child: VendorShimmerListViewItem(),
              )
            : model.hasError
                ? LoadingStateDataView(
                    stateDataModel: StateDataModel(
                      showActionButton: true,
                      actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                        color: Colors.red,
                      ),
                      actionFunction: () => model.fetchBanners(),
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        CarouselSlider(
                          items: _getImageSliders(model.banners),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.4,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: model.banners.map(
                            (banner) {
                              int index = model.banners.indexOf(banner);
                              return Container(
                                width: 12.0,
                                height: 4.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: _current == index
                                      ? AppColor.primaryColorDark
                                      : AppColor.accentColor,
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  );
      },
    );
  }

  int _current = 0;
  List<Widget> _getImageSliders(List<CategoryBanner> banners) {
    return banners
        .map(
          (banner) => Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
              child: InkWell(
                onTap: () => widget.onBannerTapped(banner),
                child: CachedNetworkImage(
                  imageUrl: banner.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
