import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/product_model.dart';
import 'package:swape_user_app/provider/localization_provider.dart';
import 'package:swape_user_app/provider/product_provider.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/view/basewidget/product_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:swape_user_app/view/basewidget/product_widget3.dart';

class FeaturedProductView extends StatelessWidget {
  final ScrollController scrollController;
  final bool isHome;

  FeaturedProductView({this.scrollController, @required this.isHome});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .featuredProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false)
              .isFeaturedLoading) {
        int pageSize;

        pageSize = Provider.of<ProductProvider>(context, listen: false)
            .featuredPageSize;

        if (offset < pageSize) {
          offset++;
          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();

          Provider.of<ProductProvider>(context, listen: false)
              .getLatestProductList(
            offset.toString(),
            context,
            Provider.of<LocalizationProvider>(context, listen: false)
                .locale
                .languageCode,
          );
        }
      }
    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.featuredProductList;

        return Column(children: [
          !prodProvider.firstFeaturedLoading
              ? productList.length != 0
                  ? Container(
                      height: 235,
                      child: isHome
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productList.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        35,
                                    child: FeaturedProductWidget1(
                                        featuredProductModel:
                                            productList[index]));
                              })
                          : StaggeredGridView.countBuilder(
                              itemCount: productList.length,
                              crossAxisCount: 2,
                              padding: EdgeInsets.all(0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                              itemBuilder: (BuildContext context, int index) {
                                return FeaturedProductWidget1(
                                    featuredProductModel: productList[index]);
                              },
                            ),
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true,
                  isEnabled: prodProvider.firstFeaturedLoading),
          prodProvider.isFeaturedLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}