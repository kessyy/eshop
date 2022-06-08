import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/product_model.dart';
import 'package:swape_user_app/helper/price_converter.dart';
import 'package:swape_user_app/provider/splash_provider.dart';
import 'package:swape_user_app/provider/theme_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class FeaturedProductWidget extends StatelessWidget {
  final Product featuredProductModel;
  FeaturedProductWidget(
      {@required this.featuredProductModel, CategoryIds child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) =>
                  ProductDetails(product: featuredProductModel),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          // boxShadow: [
          //   BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 2)],
        ),
        child: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Product Image
                Container(
                  height: 150,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color(0xff000000),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    fit: BoxFit.fill,
                    image:
                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${featuredProductModel.thumbnail}',
                    imageErrorBuilder: (c, o, s) =>
                        Image.asset(Images.placeholder, fit: BoxFit.fill),
                  ),
                  // constraints: BoxConstraints.expand(),
                ),

                // Product Details
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: 35,
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(productModel.name ?? '', style: robotoRegular, maxLines: 1, overflow: TextOverflow.ellipsis),
                        // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        Row(children: [
                          Text(
                            PriceConverter.convertPrice(
                                context, featuredProductModel.unitPrice ?? 0.0,
                                discountType: featuredProductModel.discountType,
                                discount: featuredProductModel.discount),
                            style: robotoBold.copyWith(color: Colors.black),
                          ),

                          Expanded(child: SizedBox.shrink()),

                          // Text(productModel.rating != null ? productModel.rating.length != 0 ? double.parse(productModel.rating[0].average).toStringAsFixed(1) : '0.0' : '0.0',
                          //     style: robotoRegular.copyWith(
                          //       color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,
                          //       fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          //     )),

                          // Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black, size: 10),
                        ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        featuredProductModel.discount > 0 &&
                                featuredProductModel.discount != null
                            ? Text(
                                PriceConverter.convertPrice(
                                    context, featuredProductModel.unitPrice),
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ]),

          // Off

          featuredProductModel.discount >= 1
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        PriceConverter.percentageCalculation(
                            context,
                            featuredProductModel.unitPrice,
                            featuredProductModel.discount,
                            featuredProductModel.discountType),
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).highlightColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ]),
      ),
    );
  }
}
