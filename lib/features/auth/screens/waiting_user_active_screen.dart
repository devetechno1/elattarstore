import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

import 'auth_screen.dart';

class WaitingUserActiveScreen extends StatelessWidget {
  const WaitingUserActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (d, r) => goLogin(),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.marginSizeAuthSmall),
                child: Center(
                  child: Image.asset(
                    Images.waitingLogo,
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                ),
              ),
              Text(
                getTranslated('thankYou', context)!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: Dimensions.marginSizeAuthSmall),
              Center(
                child: Image.asset(
                  Images.waitingImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).shortestSide,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.marginSizeAuthSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      getTranslated('waitingForActivation', context)!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getTranslated('pleaseWait', context)!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getTranslated('thisMayTakeFewMinutes', context)!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Center(
                child: FilledButton(
                  onPressed: goLogin,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(getTranslated('backToLogIn', context)!),
                ),
              ),
              const SizedBox(height: Dimensions.marginSizeAuthSmall)
            ],
          ),
        ),
      ),
    );
  }

  void goLogin() {
    Navigator.of(Get.context!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthScreen(initIndex: 0)),
      (r) => false,
    );
  }
}
