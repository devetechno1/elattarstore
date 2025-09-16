import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/string_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/otp_verification_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/enums/from_page.dart';

import '../../../main.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController? _userInputController;

  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();

  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userInputController = TextEditingController();
    final AuthController authProvider =
        Provider.of<AuthController>(context, listen: false);

    authProvider.clearVerificationMessage();
    authProvider.setIsLoading = false;
    authProvider.setIsPhoneVerificationButttonLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ConfigModel configModel =
        Provider.of<SplashController>(context, listen: false).configModel!;
    return Scaffold(
      floatingActionButton: whatsappButton(context),
      key: _key,
      appBar: CustomAppBar(title: getTranslated('forget_password', context)),
      body: Consumer<AuthController>(builder: (context, authProvider, _) {
        return Consumer<SplashController>(
            builder: (context, splashProvider, _) {
          return Form(
            key: forgetFormKey,
            child: ListView(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                children: [
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Image.asset(Images.logoWithNameImage,
                              height: 150, width: 150))),
                  Text(getTranslated('forget_password', context)!,
                      style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),

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
                            color: Theme.of(context).primaryColor))
                  ]),

                  splashProvider.configModel!.forgotPasswordVerification ==
                          "phone"
                      ? Text(
                          getTranslated('enter_phone_number_for_password_reset',
                              context)!,
                          style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeDefault))
                      : Text(
                          getTranslated(
                              'enter_email_for_password_reset', context)!,
                          style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeDefault)),
                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  // splashProvider.configModel!.forgotPasswordVerification == "phone"?
                  CustomTextFieldWidget(
                    textDirection: TextDirection.ltr,
                    inputType: TextInputType.emailAddress,
                    hintText: '',
                    isShowBorder: true,
                    controller: _userInputController,
                    labelText: getTranslated('email', context),
                  ),

                  const SizedBox(height: 100),

                  CustomButton(
                    isLoading: (authProvider.isLoading ||
                        authProvider.isForgotPasswordLoading),
                    buttonText: getTranslated('send', context),
                    onTap: () async {
                      if (forgetFormKey.currentState?.validate() ?? false) {
                        if (_userInputController!.text.isEmpty) {
                          showCustomSnackBar(
                              getTranslated('enter_phone_number', context),
                              context);
                        } else {
                          String userInput =
                              _userInputController!.text.removeZerosInFirst;

                          ResponseModel? response =
                              await authProvider.forgetPassword(
                                  config: configModel,
                                  phoneOrEmail: userInput,
                                  type: 'email');
                          if (response != null && response.isSuccess) {
                            if (authProvider.sendToEmail) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VerificationScreen(
                                          userInput, FromPage.forgetPassword)));
                            } else {
                              showCustomSnackBar(response.message, context,
                                  isError: false);
                            }
                          } else if (response != null && !response.isSuccess) {
                            showCustomSnackBar(response.message, context);
                          }
                        }
                      }
                    },
                  ),
                ]),
          );
        });
      }),
    );
  }
}
