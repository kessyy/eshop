import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/category.dart';
import 'package:swape_user_app/provider/category_provider.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/view/screen/home/category1.dart';
import 'package:swape_user_app/view/screen/home/home_screen.dart';
import 'package:swape_user_app/view/screen/home/category2.dart';
// import 'package:swape_user_app/view/screen/home/men.dart';
import 'package:swape_user_app/view/screen/home/category4.dart';
import 'package:provider/provider.dart';

// class TabNavigatorRoutes {
//   static const String root = '/';
//   static const String men = '/MenScreen()';
//   static const String women = '/WomenScreen()';
//   static const String kid = '/KidsScreen()';
// }

const double BAR_WIDTH = double.infinity;

class NewMenuScreen extends StatelessWidget {
  final bool isHomePage;
  NewMenuScreen({@required this.isHomePage});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: SizedBox(child: Container(
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.length != 0
                  ? Row(children: [
                      Container(
                        width: 500,
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.white)],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider.categoryList.length,
                          itemBuilder: (context, index) {
                            AllCategory _category =
                                categoryProvider.categoryList[index];
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Category1Screen()));
                                } else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Category2Screen()));
                                } else if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Category1Screen()));
                                } else if (index == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Category4Screen()));
                                }
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .changeSelectedIndex(index);
                              },
                              child: CategoryItem(
                                title: _category.name,
                                isSelected:
                                    categoryProvider.categorySelectedIndex ==
                                        index,
                              ),
                            );
                          },
                        ),
                      ),
                    ])
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)));
            },
          ),
        )));
  }

  Route<Object> bottomNavigationBar(
      {bool fullscreenDialog,
      HomePageScreen Function(BuildContext context) builder}) {}
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  CategoryItem({@required this.title, @required this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 25,
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: 12.0,
                  color: isSelected ? Color(0xFF535353) : Color(0xFFACACAC),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20 / 4), //top padding 5
            height: 2,
            width: 30,
            color: isSelected ? Colors.black : Colors.transparent,
          )
        ]),
      ),
    );
  }
}
