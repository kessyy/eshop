import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/provider/banner_provider.dart';
import 'package:swape_user_app/provider/splash_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BannersSingleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, bannerProvider, child) {
            double _width = MediaQuery.of(context).size.width;
            return Container(
              width: _width,
              height: _width * 0.5,
              child: bannerProvider.mainBannerList != null
                  ? bannerProvider.mainBannerList.length != 0
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 1.5,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                disableCenter: true,
                                onPageChanged: (index, reason) {
                                  Provider.of<BannerProvider>(context,
                                          listen: false)
                                      .setCurrentIndex(index);
                                },
                              ),
                              itemCount:
                                  bannerProvider.mainBannerList.length == 0
                                      ? 1
                                      : bannerProvider.mainBannerList.length,
                              itemBuilder: (context, index, _) {
                                return InkWell(
                                  onTap: () => _launchUrl(
                                      bannerProvider.mainBannerList[index].url),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        fit: BoxFit.cover,
                                        image:
                                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls.bannerImageUrl}'
                                            '/${bannerProvider.mainBannerList[index].photo}',
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.placeholder,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : Center(child: Text('No banner available'))
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: bannerProvider.mainBannerList == null,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorResources.WHITE,
                          )),
                    ),
            );
          },
        ),
        SizedBox(height: 5),
      ],
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
