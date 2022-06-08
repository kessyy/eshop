import 'package:flutter/material.dart';

import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/providers.dart';
import 'package:swape_user_app/utill/utils.dart';
import 'package:swape_user_app/view/basewidget/basewidgets.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        decoration: BoxDecoration(
          image: Provider.of<ThemeProvider>(context).darkTheme
              ? null
              : DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SafeArea(
                child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            )),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(70),
                      child: Image.asset(Images.logo_with_name_image,
                          height: 150, width: 150),
                    ),
                    Text(getTranslated('FORGET_PASSWORD', context),
                        style: titilliumSemiBold),
                    Row(children: [
                      Expanded(
                          flex: 1,
                          child: Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor)),
                      Expanded(
                          flex: 2,
                          child: Divider(
                              thickness: 0.2,
                              color: Theme.of(context).primaryColor)),
                    ]),
                    Text(
                        getTranslated(
                            'enter_email_for_password_reset', context),
                        style: titilliumRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      controller: _controller,
                      hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 100),
                    Builder(
                      builder: (context) => !Provider.of<AuthProvider>(context)
                              .isLoading
                          ? CustomButton(
                              buttonText: getTranslated('send_email', context),
                              onTap: () {
                                if (_controller.text.isEmpty) {
                                  _key.currentState.showSnackBar(SnackBar(
                                      content: Text(getTranslated(
                                          'EMAIL_MUST_BE_REQUIRED', context)),
                                      backgroundColor: Colors.red));
                                } else {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .forgetPassword(_controller.text)
                                      .then((value) {
                                    if (value.isSuccess) {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      _controller.clear();

                                      showAnimatedDialog(
                                          context,
                                          MyDialog(
                                            icon: Icons.send,
                                            title:
                                                getTranslated('sent', context),
                                            description: getTranslated(
                                                'recovery_link_sent', context),
                                            rotateAngle: 5.5,
                                          ),
                                          dismissible: false);
                                    } else {
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text(value.message),
                                          backgroundColor: Colors.red));
                                    }
                                  });
                                }
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
