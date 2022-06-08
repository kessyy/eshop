import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/product_model.dart';
import 'package:swape_user_app/provider/product_details_provider.dart';
import 'package:swape_user_app/provider/theme_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ProductVariation extends StatefulWidget {
  final Product product;
  final Function callback;
  ProductVariation({@required this.product, this.callback});

  @override
  _ProductVariationState createState() => _ProductVariationState();
}

class _ProductVariationState extends State<ProductVariation> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Consumer<ProductDetailsProvider>(
            builder: (context, details, child) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Variant
                    widget.product.colors.length > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(('Available in:'), style: robotoBold),
                                SizedBox(
                                  height: 25,
                                  child: ListView.builder(
                                    itemCount: widget.product.colors.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      String colorString = '0xff' +
                                          widget.product.colors[index].code
                                              .substring(1, 7);
                                      return InkWell(
                                        onTap: () {
                                          Provider.of<ProductDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .setCartVariantIndex(index);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                Color(int.parse(colorString)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Provider.of<ThemeProvider>(
                                                                  context)
                                                              .darkTheme
                                                          ? 700
                                                          : 200],
                                                  spreadRadius: 1,
                                                  blurRadius: 5)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ])
                        : SizedBox.shrink(),
                    widget.product.colors.length > 0
                        ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
                        : SizedBox.shrink(),

                    // Variation
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.product.choiceOptions.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.choiceOptions[index].title,
                                  style: robotoBold),
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: (0.7 / 0.25),
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.product.choiceOptions[index]
                                    .options.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      decoration: BoxDecoration(
                                        color: details.variationIndex[index] !=
                                                i
                                            ? Theme.of(context).highlightColor
                                            : ColorResources.getPrimary(
                                                context),
                                        borderRadius: BorderRadius.circular(5),
                                        border: details.variationIndex[index] !=
                                                i
                                            ? Border.all(
                                                color:
                                                    Theme.of(context).hintColor,
                                                width: 2)
                                            : null,
                                      ),
                                      child: Text(
                                          widget.product.choiceOptions[index]
                                              .options[i],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: titilliumRegular.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL,
                                            color:
                                                details.variationIndex[index] !=
                                                        i
                                                    ? Theme.of(context)
                                                        .hintColor
                                                    : Theme.of(context)
                                                        .highlightColor,
                                          )),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            ]);
                      },
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  ]);
            },
          ),
        ),
      ],
    );
  }
}
