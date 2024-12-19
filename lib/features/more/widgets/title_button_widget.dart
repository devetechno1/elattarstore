import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MenuButtonWidget extends StatelessWidget {
  final String image;
  final String? title;
  final Widget? navigateTo;
  final bool isNotification;
  final bool isProfile;
  final IconData? icon;
  final void Function()? onTap;
  const MenuButtonWidget({
    super.key,
    required this.image,
    required this.title,
    this.navigateTo,
    this.isNotification = false,
    this.isProfile = false,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: isNotification
            ? Consumer<NotificationController>(
                builder: (context, notificationController, _) {
                return CircleAvatar(
                  radius: 12,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                      notificationController
                              .notificationModel?.newNotificationItem
                              .toString() ??
                          '0',
                      style: textRegular.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeSmall)),
                );
              })
            : isProfile
                ? Consumer<ProfileController>(
                    builder: (context, profileProvider, _) {
                    return CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                            profileProvider.userInfoModel?.referCount
                                    .toString() ??
                                '0',
                            style: textRegular.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall)));
                  })
                : const SizedBox(),
        leading: image.isEmpty && icon != null
            ? FaIcon(
                icon,
                size: 25,
                color: Theme.of(context).primaryColor.withOpacity(.7),
              )
            : Image.asset(
                image,
                width: 25,
                height: 25,
                fit: BoxFit.fill,
                color: Theme.of(context).primaryColor.withOpacity(.7),
              ),
        title: Text(title!,
            style:
                titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
        onTap: () {
          onTap?.call();
          if (navigateTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => navigateTo!),
            );
          }
        });
  }
}
