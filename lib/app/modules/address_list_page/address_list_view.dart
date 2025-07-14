import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/modules/address_list_page/add_or_edit_address_page/add_or_edit_address_view.dart';
import 'package:sakani/app/modules/address_list_page/widgets/address_list_item.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import '../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import '../../utils/constants/app_constants.dart';
import 'add_or_edit_address_page/arguments/add_or_edit_address_page_args.dart';
import 'address_list_controller.dart';

class AddressListPage extends GetView<AddressListController> {
  static const String routeName = '/app/address-list';

  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_CUSTOMER_ADDRESS.translate,
        showCartIcon: false,
        actions: [
          AppCard(
            withAlignment: false,
            onTap: controller.addNewAddress,
            radius: 12.r,
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
      body: GetBuilder<AddressListController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchAddressList,
                )
              : SkeletonOfListView<Address>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData:
                      controller.addressListData?.addresses?.isNullOrEmpty ==
                          true,
                  fakeObject: Address.fake(),
                  realData: controller.addressListData?.addresses,
                  itemBuilder: (item, index) {
                    return ItemAddressList(
                      address: item,
                      onEditClicked: (Address address) {
                        if (address.id != null) {
                          Get.toNamed(
                            AddOrEditAddressPage.routeName,
                            arguments: AddOrEditAddressPageArgs(
                              isEditMode: true,
                              addressId: address.id!,
                            ),
                          )?.then((value) {
                            if (value.toString() ==
                                AppConstants.keyRefreshContent) {
                              controller.fetchAddressList();
                            }
                          });
                        }
                      },
                      onDeleteClicked: controller.onDeleteAddress,
                    );
                  },
                );
        },
      ),
    );
  }
}
