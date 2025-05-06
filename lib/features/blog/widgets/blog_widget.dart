import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';

import '../domain/models/blog_model.dart';

class BlogWidget extends StatelessWidget {
  final BlogModel blog;
  final int index;
  final int length;
  const BlogWidget({
    super.key,
    required this.blog,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.125),
                width: .25,
              ),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              color: Theme.of(context).primaryColor.withOpacity(.125),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: CustomImageWidget(image: '${blog.imageFullUrl?.path}'),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Flexible(
            child: Text(
              blog.name ?? '',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: ColorResources.getTextTitle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
