import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/priority_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_type_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class AddTicketScreen extends StatefulWidget {
  final TicketModel ticketModel;
  final String type;
  final bool isBackButtonExist;
  const AddTicketScreen({
    super.key,
    required this.ticketModel,
    required this.type,
    this.isBackButtonExist = true,
  });

  @override
  AddTicketScreenState createState() => AddTicketScreenState();
}

class AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _subjectNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _areaNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late final c = Provider.of<SupportTicketController>(context, listen: false);

  @override
  void initState() {
    if (widget.type == 'info_inquiry') {
      c.initData(['purchase', 'sale'], 'select_sale_purchase');
    } else {
      c.initData(['urgent', 'high', 'medium', 'low'], 'select_priority');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: whatsappButton(context),
      appBar: CustomAppBar(
        title: getTranslated('add_new_ticket', context),
        isBackButtonExist: widget.isBackButtonExist,
      ),
      body: Consumer<SupportTicketController>(
          builder: (context, supportTicketProvider, _) {
        return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeTwelve),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.125),
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.15)),
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeEight)),
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.paddingSizeLarge),
                  child: Row(children: [
                    SizedBox(
                        width: 20, child: Image.asset(widget.ticketModel.icon)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: Text(
                            getTranslated(widget.ticketModel.title, context)!,
                            style: textBold))
                  ])),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                  child: InkWell(
                      onTap: () => showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => const PriorityBottomSheetWidget()),
                      child: Container(
                          width: MediaQuery.of(context).size.width * .5,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.5))),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              child: Row(children: [
                                Expanded(
                                    child: Text(
                                        getTranslated(
                                                supportTicketProvider
                                                    .selectedPriority,
                                                context) ??
                                            supportTicketProvider
                                                .selectedPriority,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textRegular.copyWith(
                                          color: supportTicketProvider.selectedPriorityIndex == -1? Theme.of(context).disabledColor : null,
                                            fontSize:
                                                Dimensions.fontSizeLarge))),
                                const Icon(Icons.arrow_drop_down)
                              ]))))),
              CustomTextFieldWidget(
                focusNode: _subjectNode,
                nextFocus: _phoneNode,
                required: true,
                inputAction: TextInputAction.next,
                labelText: '${getTranslated('item_name', context)}',
                hintText: getTranslated('item_name', context),
                controller: _subjectController,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              CustomTextFieldWidget(
                required: true,
                focusNode: _phoneNode,
                nextFocus: _areaNode,
                hintText: getTranslated('PHONE_NO', context),
                inputType: TextInputType.phone,
                controller: _phoneController,
                labelText: '${getTranslated('phone', context)}',
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              CustomTextFieldWidget(
                required: true,
                focusNode: _areaNode,
                nextFocus: _descriptionNode,
                hintText: getTranslated('area', context),
                inputType: TextInputType.streetAddress,
                controller: _areaController,
                labelText: '${getTranslated('area', context)}',
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              CustomTextFieldWidget(
                  required: true,
                  focusNode: _descriptionNode,
                  inputAction: TextInputAction.newline,
                  hintText: getTranslated('description', context),
                  inputType: TextInputType.multiline,
                  controller: _descriptionController,
                  labelText: '${getTranslated('description', context)}',
                  maxLines: 5),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      supportTicketProvider.pickedImageFileStored.length + 1,
                  itemBuilder: (BuildContext context, index) {
                    return index ==
                            supportTicketProvider.pickedImageFileStored.length
                        ? InkWell(
                            onTap: () =>
                                supportTicketProvider.pickMultipleImage(
                                  false,
                                ),
                            child: DottedBorder(
                                strokeWidth: 2,
                                dashPattern: const [10, 5],
                                color: Theme.of(context).hintColor,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(
                                    Dimensions.paddingSizeSmall),
                                child: Stack(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.paddingSizeSmall),
                                      child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child:
                                              Image.asset(Images.placeholder))),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.07),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .paddingSizeSmall))))
                                ])))
                        : Stack(children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.paddingSizeSmall),
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(Dimensions
                                                .paddingSizeExtraSmall)),
                                        child: Image.file(
                                            File(supportTicketProvider
                                                .pickedImageFileStored[index]
                                                .path),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.3,
                                            fit: BoxFit.cover)))),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                    onTap: () => supportTicketProvider
                                        .pickMultipleImage(true, index: index),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimensions
                                                    .paddingSizeDefault))),
                                        child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(
                                                Icons.delete_forever_rounded,
                                                color: Colors.red,
                                                size: 15)))))
                          ]);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10)),
            ]);
      }),
      bottomNavigationBar: Provider.of<SupportTicketController>(context)
              .isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor))),
              ],
            )
          : Container(
              color: Theme.of(context).cardColor,
              child: Consumer<SupportTicketController>(
                key: _scaffoldKey,
                builder: (context, supportTicketProvider, _) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeSmall),
                  child: CustomButton(
                      buttonText: getTranslated('submit', context),
                      onTap: () {
                        if (supportTicketProvider.selectedPriorityIndex == -1) {
                          if(widget.type == 'info_inquiry'){
                            showCustomSnackBar(
                              getTranslated('select_sale_purchase_required', context),
                              context);
                          }else{
                            showCustomSnackBar(
                            getTranslated('priority_is_required', context),
                            context);
                          }
                        }else if (_subjectController.text.isEmpty) {
                          showCustomSnackBar(
                              getTranslated('item_name_is_required', context),
                              context);
                        } else if (_phoneController.text.isEmpty) {
                          showCustomSnackBar(
                              getTranslated('phone_is_required', context),
                              context);
                        } else if (_areaController.text.isEmpty) {
                          showCustomSnackBar(
                              getTranslated('area_is_required', context),
                              context);
                        } else if (_descriptionController.text.isEmpty) {
                          showCustomSnackBar(
                              getTranslated('description_is_required', context),
                              context);
                        } else {
                          final String description =
                              "${getTranslated('phone', context)}: ${_phoneController.text.trim()}\n${getTranslated('area', context)}: ${_areaController.text.trim()}\n${getTranslated('description', context)}: ${_descriptionController.text.trim()}";
                          SupportTicketBody supportTicketModel =
                              SupportTicketBody(
                            widget.ticketModel.title,
                            _subjectController.text,
                            description,
                            supportTicketProvider.selectedPriority,
                          );
                          supportTicketProvider
                              .createSupportTicket(supportTicketModel);
                        }
                      }),
                ),
              ),
            ),
    );
  }
}
