import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/providers.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import 'category_single.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  CategoryView({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (0.5 / 0.5),
                ),
                itemCount: isHomePage
                    ? categoryProvider.categoryList.length > 8
                        ? 8
                        : categoryProvider.categoryList.length
                    : categoryProvider.categoryList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BrandAndCategoryProductScreen(
                                    isBrand: false,
                                    id: categoryProvider.categoryList[index].id
                                        .toString(),
                                    name: categoryProvider
                                        .categoryList[index].name,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 20,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                        color: Color(0xffFFFFFF),
                        // boxShadow: [BoxShadow(
                        //   color: Colors.grey.withOpacity(0.3),
                        //   spreadRadius: 1,
                        //   blurRadius: 3,
                        //   offset: Offset(0, 3), // changes position of shadow
                        // )],
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: ColorResources.getTextBg(context),
                                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      ),
                                  child: Center(
                                    child: Text(
                                      categoryProvider.categoryList.length != 0
                                          ? categoryProvider
                                              .categoryList[index].name
                                          : getTranslated('CATEGORY', context),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: titilliumSemiBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL),
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    image:
                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}'
                                        '/${categoryProvider.categoryList[index].icon}',
                                    imageErrorBuilder: (c, o, s) =>
                                        Image.asset(Images.placeholder),
                                    height: 15,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              )
            : CategoryShimmer();
      },
    );
  }
}
