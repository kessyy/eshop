import 'package:flutter/material.dart';

import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/providers.dart';
import 'package:swape_user_app/utill/utils.dart';
import 'widget/sign_in_widget.dart';
import 'widget/register_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  final int initialPage;
  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressTypeList(context);
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // background
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),

          Consumer<AuthProvider>(
            builder: (context, auth, child) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),

                  // for logo with text
                  Image.asset(Images.logo_with_name_image,
                      height: 150, width: 150),

                  // for decision making section like signin or register section
                  Padding(
                    padding:
                        EdgeInsets.only(left: Dimensions.MARGIN_SIZE_LARGE),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          left: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                right: Dimensions.FONT_SIZE_LARGE),
                            height: 1,
                            color: ColorResources.getGainsBoro(context),
                          ),
                        ),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) => Row(
                            children: [
                              InkWell(
                                onTap: () => _pageController.animateToPage(0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Column(
                                  children: [
                                    Text('SIGN IN',
                                        style: authProvider.selectedIndex == 0
                                            ? titilliumSemiBold
                                            : titilliumRegular),
                                    Container(
                                      height: 1,
                                      width: 40,
                                      margin: EdgeInsets.only(top: 8),
                                      color: authProvider.selectedIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 25),
                              InkWell(
                                onTap: () => _pageController.animateToPage(1,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Column(
                                  children: [
                                    Text('REGISTER',
                                        style: authProvider.selectedIndex == 1
                                            ? titilliumSemiBold
                                            : titilliumRegular),
                                    Container(
                                        height: 1,
                                        width: 50,
                                        margin: EdgeInsets.only(top: 8),
                                        color: authProvider.selectedIndex == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // show login or register widget
                  Expanded(
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) =>
                          PageView.builder(
                        itemCount: 2,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          if (authProvider.selectedIndex == 0) {
                            return SignInWidget();
                          } else {
                            return SignUpWidget();
                          }
                        },
                        onPageChanged: (index) {
                          authProvider.updateSelectedIndex(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}