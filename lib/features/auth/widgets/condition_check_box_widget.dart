import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/html_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ConditionCheckBox extends StatelessWidget {
  const ConditionCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController =
        Provider.of<SplashController>(context, listen: false);

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Consumer<AuthController>(builder: (ctx, authController, _) {
        return GestureDetector(
          onTap: authController.toggleTermsCheck,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.brightness == Brightness.light? Colors.white : Colors.black,
                border: Border.all(
                    color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(3),
              ),
              child: authController.isAcceptTerms
                  ? Icon(Icons.done,
                      color: Theme.of(context).primaryColor,
                      size: 14)
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Text(getTranslated('i_agree_with_the', context)!,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).colorScheme.primary,
                )),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HtmlViewScreen(
                            title: getTranslated('terms_condition', context),
                            url: splashController.configModel?.termsConditions,
                          ))),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Text(getTranslated('terms_condition', context)!,
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
