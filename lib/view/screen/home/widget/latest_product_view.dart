import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/product_model.dart';
import 'package:swape_user_app/provider/localization_provider.dart';
import 'package:swape_user_app/provider/product_provider.dart';
import 'package:swape_user_app/view/basewidget/product_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:swape_user_app/view/basewidget/product_widget3.dart';

class LatestProductView extends StatelessWidget {
  final ScrollController scrollController;
  LatestProductView({this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .lProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
        pageSize =
            Provider.of<ProductProvider>(context, listen: false).lPageSize;

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
        productList = prodProvider.lProductList;

        return Column(children: [
          !prodProvider.firstLoading
              ? productList.length != 0
                  ? Container(
                      height: 250,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    35,
                                child: FeaturedProductWidget1(
                                    featuredProductModel: productList[index]));
                          }),
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true, isEnabled: prodProvider.firstLoading),
          // prodProvider.isLoading
          //     ? Center(
          //         child: Padding(
          //         padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
          //         child: CircularProgressIndicator(
          //             valueColor: AlwaysStoppedAnimation<Color>(
          //                 Theme.of(context).primaryColor)),
          //       ))
          //     : SizedBox.shrink(),
        ]);
      },
    );
  }
}
