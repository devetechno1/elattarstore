import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../auth/screens/auth_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;
  OnBoardingScreen(
      {super.key,
      this.indicatorColor = Colors.grey,
      this.selectedIndicatorColor = Colors.black});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingController>(context, listen: false)
        .getOnBoardingList();

    double height = MediaQuery.of(context).size.height;

    double imageSize =
        MediaQuery.sizeOf(context).width - Dimensions.paddingSizeDefault;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).shortestSide,
          child: Consumer<OnBoardingController>(
              builder: (context, onBoardingList, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Consumer<OnBoardingController>(
                  builder: (context, onBoardingList, child) => ListView(
                    children: [
                      SizedBox(height: height * 0.04),
                      Center(
                        child: Image.asset(
                          Images.logoWithNameImageWhite,
                          width: 250,
                        ),
                      ),
                      SizedBox(
                          height: height * 0.7,
                          child: PageView.builder(
                              itemCount: onBoardingList.onBoardingList.length,
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image.asset(
                                            onBoardingList
                                                .onBoardingList[index].imageUrl,
                                            width: imageSize,
                                            height: imageSize,
                                            alignment: Alignment.bottomCenter,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 28,
                                        ),
                                        child: Html(
                                          shrinkWrap: true,
                                          data: onBoardingList
                                              .onBoardingList[index].html,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical:
                                      //           Dimensions.paddingSizeDefault),
                                      //   child: Text(
                                      //     onBoardingList
                                      //         .onBoardingList[index].text,
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .headlineLarge,
                                      //     textAlign: TextAlign.center,
                                      //   ),
                                      // ),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeDefault),
                                    ],
                                  ),
                                );
                              },
                              onPageChanged: (index) {
                                if (index !=
                                    onBoardingList.onBoardingList.length) {
                                  onBoardingList.changeSelectIndex(index);
                                } else {
                                  if (AppConstants.shouldLoginFirst) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const AuthScreen()),
                                        (route) => false);
                                  } else {
                                    Provider.of<SplashController>(context,
                                            listen: false)
                                        .disableIntro();
                                    Provider.of<AuthController>(context,
                                            listen: false)
                                        .getGuestIdUrl();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const DashBoardScreen()),
                                        (route) => false);
                                  }
                                }
                              })),
                      onBoardingList.selectedIndex ==
                              onBoardingList.onBoardingList.length - 1
                          ? Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Center(
                                  child: SizedBox(
                                      width: 100,
                                      child: CustomButton(
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        radius: 5,
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.1),
                                        buttonText:
                                            getTranslated("explore", context),
                                        onTap: () {
                                          if (AppConstants.shouldLoginFirst) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const AuthScreen()),
                                                (route) => false);
                                          } else {
                                            Provider.of<SplashController>(
                                                    context,
                                                    listen: false)
                                                .disableIntro();
                                            Provider.of<AuthController>(context,
                                                    listen: false)
                                                .getGuestIdUrl();
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const DashBoardScreen()),
                                                (route) => false);
                                          }
                                        },
                                      ))))
                          : linearIndicator(onBoardingList)
                    ],
                  ),
                ),
                if (onBoardingList.selectedIndex !=
                    onBoardingList.onBoardingList.length - 1)
                  Positioned(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                if (AppConstants.shouldLoginFirst) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const AuthScreen()),
                                      (route) => false);
                                } else {
                                  Provider.of<SplashController>(context,
                                          listen: false)
                                      .disableIntro();
                                  Provider.of<AuthController>(context,
                                          listen: false)
                                      .getGuestIdUrl();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const DashBoardScreen()),
                                      (route) => false);
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 20),
                                  child: Text(
                                      '${getTranslated('skip', context)}',
                                      style: textMedium.copyWith(
                                          fontSize: Dimensions.fontSizeLarge,
                                          color: Theme.of(context)
                                              .primaryColor))))))
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget linearIndicator(OnBoardingController onBoardingList) {
    if (onBoardingList.onBoardingList.isEmpty) return const SizedBox();

    final double value = (onBoardingList.selectedIndex + 1) /
        onBoardingList.onBoardingList.length;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeExtraLarge,
        horizontal: Dimensions.paddingSizeExtraLarge + 28,
      ),
      height: 50,
      child: LayoutBuilder(
        builder: (context, constrained) {
          final double onePart =
              (constrained.maxWidth / onBoardingList.onBoardingList.length);
          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 20,
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              PositionedDirectional(
                start: (constrained.maxWidth * value) - onePart,
                child: GestureDetector(
                  onTap: () {
                    if (onBoardingList.selectedIndex ==
                        onBoardingList.onBoardingList.length - 1) {
                      if (AppConstants.shouldLoginFirst) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AuthScreen()),
                            (route) => false);
                      } else {
                        Provider.of<SplashController>(context, listen: false)
                            .disableIntro();
                        Provider.of<AuthController>(context, listen: false)
                            .getGuestIdUrl();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DashBoardScreen()),
                            (route) => false);
                      }
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: onePart,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Icon(
                      onBoardingList.selectedIndex ==
                              onBoardingList.onBoardingList.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
