import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/product_model.dart';
import 'package:swape_user_app/helper/product_type.dart';
import 'package:swape_user_app/provider/localization_provider.dart';
import 'package:swape_user_app/provider/product_provider.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/view/basewidget/product_shimmer.dart';
import 'package:swape_user_app/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:swape_user_app/view/basewidget/product_widget2.dart';

class ProductView extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView(
      {@required this.isHomePage,
      @required this.productType,
      this.scrollController,
      this.sellerId});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .latestProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false)
              .filterIsLoading) {
        int pageSize;
        if (productType == ProductType.BEST_SELLING ||
            productType == ProductType.TOP_PRODUCT ||
            productType == ProductType.NEW_ARRIVAL) {
          pageSize = Provider.of<ProductProvider>(context, listen: false)
              .latestPageSize;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          pageSize = Provider.of<ProductProvider>(context, listen: false)
              .sellerPageSize;
        }
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
        List<Product> productList = [];
        if (productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.lProductList;
        } else if (productType == ProductType.FEATURED_PRODUCT) {
          productList = prodProvider.featuredProductList;
        } else if (productType == ProductType.TOP_PRODUCT) {
          productList = prodProvider.latestProductList;
          print('===============>${productList.length}');
        } else if (productType == ProductType.BEST_SELLING) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.NEW_ARRIVAL) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
        }

        return Column(children: [
          !prodProvider.filterFirstLoading
              ? productList.length != 0
                  ? StaggeredGridView.countBuilder(
                      itemCount: isHomePage
                          ? productList.length > 4
                              ? 4
                              : productList.length
                          : productList.length,
                      crossAxisCount: 3,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return FeaturedProductWidget(
                            featuredProductModel: productList[index]);
                      },
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: isHomePage, isEnabled: prodProvider.firstLoading),
          prodProvider.filterIsLoading
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
