import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/brand_provider.dart';
import 'package:swape_user_app/provider/theme_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/home/widget/brand_view.dart';
import 'package:provider/provider.dart';

class AllBrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, size: 20, color: ColorResources.BLACK),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(getTranslated('all_brand', context),
            style: titilliumRegular.copyWith(
                fontSize: 20, color: ColorResources.BLACK)),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    enabled: false,
                    child: Text(getTranslated('sort_by', context),
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: ColorResources.BLACK))),
                CheckedPopupMenuItem(
                  value: 0,
                  checked: Provider.of<BrandProvider>(context, listen: false)
                      .isTopBrand,
                  child: Text(getTranslated('top_brand', context),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL)),
                ),
                CheckedPopupMenuItem(
                  value: 1,
                  checked:
                      Provider.of<BrandProvider>(context, listen: false).isAZ,
                  child: Text(getTranslated('alphabetically_az', context),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL)),
                ),
                CheckedPopupMenuItem(
                  value: 2,
                  checked:
                      Provider.of<BrandProvider>(context, listen: false).isZA,
                  child: Text(getTranslated('alphabetically_za', context),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL)),
                ),
              ];
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            offset: Offset(0, 45),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child:
                  Image.asset(Images.filter_image, color: ColorResources.BLACK),
            ),
            onSelected: (value) {
              Provider.of<BrandProvider>(context, listen: false)
                  .sortBrandLis(value);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: BrandView(isHomePage: false),
      ),
    );
  }
}
