// file: lib/account_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var hasAccount = false.obs;

  // حقل الحساب
  final accountNumber = TextEditingController();

  // القيم المختارة
  var value1 = RxnString();
  var value2 = RxnString();
  var value3 = RxnString();

  // تحقق من الحقول
  String? validateAccount(String? val) {
    if (val == null || val.isEmpty) {
      return "الرجاء إدخال رقم الحساب";
    }
    if (val.length != 6) {
      return "يجب أن يكون 6 أرقام فقط";
    }
    return null;
  }

  String? validateValue(String? val) {
    if (val == null || val.isEmpty) {
      return "الرجاء اختيار قيمة";
    }
    return null;
  }

  @override
  void onClose() {
    accountNumber.dispose();
    super.onClose();
  }
}

Future<dynamic> showAccountBottomSheet(BuildContext context) {
  final controller = Get.put(AccountController()); // ما عاد نحذف يدوي
  final formKey = GlobalKey<FormState>();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Text(
                    "هل تمتلك حساب في بنك اليمن والكويت؟",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),

                  // أزرار نعم/لا
                  if (!controller.hasAccount.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => controller.hasAccount.value = true,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text("نعم"),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(ctx, false);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text("لا"),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  // إذا اختار نعم → عرض حقل الحساب + 3 ComboBox
                  if (controller.hasAccount.value)
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.accountNumber,
                            decoration: const InputDecoration(
                              labelText: "رقم الحساب",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6, // يمنع إدخال أكثر من 6 أرقام
                            validator: controller.validateAccount,
                          ),
                          const SizedBox(height: 12),

                          DropdownButtonFormField<String>(
                            value: controller.value1.value,
                            decoration: const InputDecoration(
                              labelText: "الخيار الأول",
                              border: OutlineInputBorder(),
                            ),
                            items: ["A", "B", "C"]
                                .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) => controller.value1.value = val,
                            validator: controller.validateValue,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: controller.value2.value,
                            decoration: const InputDecoration(
                              labelText: "الخيار الثاني",
                              border: OutlineInputBorder(),
                            ),
                            items: ["X", "Y", "Z"]
                                .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) => controller.value2.value = val,
                            validator: controller.validateValue,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: controller.value3.value,
                            decoration: const InputDecoration(
                              labelText: "الخيار الثالث",
                              border: OutlineInputBorder(),
                            ),
                            items: ["1", "2", "3"]
                                .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) => controller.value3.value = val,
                            validator: controller.validateValue,
                          ),
                          const SizedBox(height: 18),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, null),
                                child: const Text("إلغاء"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(ctx, {
                                      "hasAccount": true,
                                      "accountNumber":
                                      controller.accountNumber.text,
                                      "value1": controller.value1.value,
                                      "value2": controller.value2.value,
                                      "value3": controller.value3.value,
                                    });
                                  }
                                },
                                child: const Text("موافق"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      );
    },
  );
}

