import 'api_errors_strings.dart';
import 'app_strings.dart';

Map<String, String> ar = {
  AppStrings.comingSoon: 'قريبا',
  AppStrings.getStarted: 'البدء',

  ///.. auth
  AppStrings.hey: 'مرحباٌ',
  AppStrings.heyWelcomeBack: 'مرحبًا بعودتك',
  AppStrings.pleaseFillInHereDetailsToGetToYourAccount:
      'يرجى ملء التفاصيل هنا للوصول إلى حسابك.',
  AppStrings.login: 'تسجيل الدخول',

  AppStrings.logOut: 'تسجيل الخروج',
  // MamaMiaAppStrings.personalInformation: 'معلومات شخصية',
  AppStrings.email: 'البريد الإلكتروني',
  AppStrings.emailHint: 'يرجى أدخال بريدك الإلكتروني',
  AppStrings.password: 'كلمة المرور',
  AppStrings.forgetPassword: 'نسيت كلمة المرور ؟',
  AppStrings.resetPassword: 'اعادة ضبط كلمةالمرور',
  // AppStrings.sendResetEmail: 'ارسال ايميل لاعادة ضبط كلمةالمرور',
  // AppStrings.resetPasswordSuccessfullySend:
  //     'تم ارسال ايميل اعادة ضبط كلمةالمرور بنجاح',
  AppStrings.resetNewPasswordSentToYourEmail:
      'تم إرسال إعادة تعيين كلمة المرور الخاصة بك إلى البريد الإلكتروني الذي تم إدخاله. يرجى مراجعة صندوق البريد الإلكتروني الخاص بك',

  // AppStrings.verify: 'تحقق',
  // AppStrings.resend: 'اعادة ارسال',
  // AppStrings.wrongVerificationCode: 'رمز تحقق خاطئ',
  // AppStrings.verificationCode: 'رمز التحقق',
  // AppStrings.verificationCodeTimeOut: 'انتهت مهلة رمز التحقق',
  // AppStrings.pleaseInsertVerificationCodeThatWasSendTo:
  //     'الرجاء إدخال رمز التحقق الذي تم إرساله إلى',

  // AppStrings.rememberPassword: 'تذكرت كلمة المرور؟',
  AppStrings.newPassword: 'كلمة سر الجديدة',
  AppStrings.newPasswordHint: 'أدخل كلمة السر الجديدة',
  AppStrings.newPasswordConfirm: 'تاكيد كلمة المرور الجديدة',
  AppStrings.newPasswordConfirmHint: 'يرجى تاكيد كلمة المرور الجديدة',
  AppStrings.newPasswordChangeWithSuccessPleaseReLogin:
      'تم تغيير كلمة المرور بنجاح ، يرجى إعادة تسجيل الدخول باستخدام كلمة المرور الجديدة',
  AppStrings.newPasswordChangeWithSuccess: 'تم تغيير كلمة المرور بنجاح',
  AppStrings.passwordHint: 'أدخل كلمة المرور',
  AppStrings.passwordConfirm: 'تاكيد كلمة المرور',
  AppStrings.passwordConfirmHint: 'يرجى تاكيد كلمة المرور',
  AppStrings.currentPassword: 'كلمة المرور الحالية',
  AppStrings.currentPasswordHint: 'يرجى ادخال كلمة المرور الحالية',
  AppStrings.phoneNum: 'رقم الهاتف',
  AppStrings.phoneNumHint: 'يرجى إدخال رقم الهاتف الخاص بك',

  AppStrings.passwordsDoNotMatch: "كلمة المرور غير مطابقة",
  AppStrings.changePassword: 'تغيير كلمة المرور',
  // AppStrings.rememberMe: 'تذكرني',
  // AppStrings.reEnterNewPassword: 'أعد إدخال كلمة المرور الجديدة',
  AppStrings.fillAllField: 'من فضلك املأ كل الحقول',
  // AppStrings.ifYouAreNew: 'إذا كنت جديدًا /',
  AppStrings.ifYouHaveAccount: 'إذا كان لديك حساب /',
  AppStrings.alreadyHaveAnAccount: 'لديك حساب بالفعل',
  AppStrings.loginNow: 'سجل الدخول',
  AppStrings.ifYouAreNew: 'اذا كنت جديد/',
  AppStrings.signup: 'انشاء حساب',
  AppStrings.doNotHaveAnAccount: 'لا تملك حساب؟',
  AppStrings.signUpNow: 'أنشئ حساب',
  AppStrings.or: 'أو',
  AppStrings.updateProfile: 'تحديث الملف الشخصي',
  // AppStrings.orContinueWith: 'أو',
  AppStrings.pleaseLoginFirst: 'الرجاء تسجيل الدخول للمتابعة',
  // AppStrings.heyWelcomeBack : 'Hey,welcome Back',
  AppStrings.continueAsGuest: 'المواصلة كزائر',
  // AppStrings.loginUsingGoogle: 'تسجيل الدخول باستخدام جوجل',

  // AppStrings.yourAccountEmailIsNotVerifiedYet:
  //     'لم يتم التحقق من البريد الإلكتروني لحسابك بعد',
  // AppStrings.thisAccountHasBeenDeleted:
  //     'لقد تم حذف حسابك. يرجى تقديم طلب استرداد إذا كنت تريد استعادة حسابك',
  // AppStrings.deleteMyAccount: 'حذف حسابي',
  // AppStrings.deleteAccount: 'حذف الحساب',
  // AppStrings.areYouSureYouWantToDeleteYourAccount:
  //     'هل أنت متأكد أنك تريد حذف حسابك ، يرجى ملاحظة أنك لن تتمكن من تسجيل الدخول إلى هذا التطبيق بعد الآن',

  ///... signup
  AppStrings.userName: 'اسم المستخدم',
  // AppStrings.firstName: 'الاسم الاول',
  // MamaMiaAppStrings.conditions: 'conditions',
  // MamaMiaAppStrings.privacyPolicy: 'privacyPolicy',
  // AppStrings.lastName: 'اللقب',
  AppStrings.backToLogin: 'العودة لتسجيل الدخول',

  ///.. splash
  AppStrings.appName: 'Saned Board',

  ///.. introduction screen
  // AppStrings.agreeToPrivacy:
  //     'بأتمام عملية التسجيل, أقر بالإطلاع والموافقة على الشروط والاحكام وسياسية الخصوصية.',

  ///.. tab screen
  AppStrings.doubleClickToExitApp: "انقر مرة اخرى للخروج من التطبيق",

  ///.. home screen
  // AppStrings.home: 'الرئيسية',
  // MamaMiaAppStrings.by: "بـ",
  AppStrings.latest: "الأحدث",
  AppStrings.categories: "الفئات",
  AppStrings.brand: "الماركة",
  AppStrings.brands: "الماركات",
  // AppStrings.all: 'الكل',
  AppStrings.addNew: 'اضافة جديد',

  AppStrings.areYouSureYouWantToDeleteThisItem:
      "هل أنت متأكد أنك تريد حذف هذا العنصر",
  AppStrings.viewAll: 'مشاهدة الكل',
  AppStrings.reset: 'إعادة تعيين',
  AppStrings.addressDescription: 'وصف العنوان',

  ///... notifications screen
  AppStrings.notifications: 'إشعارات',

  ///... all category offers and clinics screen
  // AppStrings.filterWith: 'فلترة بواسطة',
  AppStrings.allProducts: 'جميع المنتجات',
  AppStrings.selectBrandsToFilterWith: 'حدد العلامات التجارية للتصفية بها:',
  AppStrings.selectCategoriesToFilterWith: 'حدد الفئات للتصفية بها:',

  // AppStrings.settings: 'الاعدادات',
  // AppStrings.appSettings: 'اعدادات التطبيق',
  AppStrings.language: 'اللغة',
  AppStrings.changeLang: 'تغيير لغة التطبيق',
  AppStrings.theme: 'الثيم',
  AppStrings.changeAppTheme: 'تغيير ثيم التطبيق',
  AppStrings.lightMode: 'الوضع النهاري',
  AppStrings.darkMode: 'الوضع الليلي',
  AppStrings.systemMode: 'وضع نظام التشغيل',
  AppStrings.cantAddMoreThan: 'لا يمكن إضافة أكثر من',
  AppStrings.cart: 'السلة',
  AppStrings.addToCart: 'أضف إلى السلة',
  AppStrings.removeFromCart: 'ازالة من السلة',
  AppStrings.total: 'الاجمالي',
  AppStrings.alreadySetWithSameQty: 'بنفس الكمية مسبقاٌ',
  AppStrings.pleaseSelectYourPreferredPaymentMethod:
      'يرجى تحديد طريقة الدفع المفضلة لديك',
  AppStrings.pleaseSelectPaymentMethodToContinue:
      'يرجى تحديد طريقة الدفع للمتابعة',
  AppStrings.coupon: 'كوبون الخصم',
  AppStrings.noCouponAdded: 'لم يتم إضافة قسيمة',
  AppStrings.fillAllData: 'يرجى ملء جميع البيانات المطلوبة',
  AppStrings.selectShippingAddress: 'يرجى تحديد عنوان الشحن',
  AppStrings.shippingAddress: 'عنوان الشحن',
  AppStrings.review: 'المراجعة والتأكيد',
  AppStrings.orderInvoice: 'فاتورة الطلب',
  AppStrings.productsPrice: 'سعر المنتجات',
  AppStrings.shippingFee: 'رسوم الشحن',
  AppStrings.areYouSureYouWantToDeleteThisAddress:
      'هل أنت متأكد أنك تريد حذف هذا العنوان',
  AppStrings.orderItems: 'عناصر الطلب',
  AppStrings.country: 'الدولة',
  AppStrings.state: 'الولاية/المدينة',
  AppStrings.city: 'المدينة',
  AppStrings.selectState: 'حدد الولايه',
  AppStrings.selectCity: 'حدد المدينة',
  AppStrings.addAddress: 'اضافة عنوان',
  AppStrings.street: 'الشارع',
  AppStrings.pickLocation: 'اختيار الموقع',
  AppStrings.pleaseAddLabelToTourPickedAddress:
      'يرجى إضافة التسمية إلى العنوان الذي اخترته',
  AppStrings.thisFieldIsRequired: 'هذا الحقل لا يمكن ان يكون فارغا',
  AppStrings.changeDefaultCurrency: 'تغيير العملة الافتراضية',
  AppStrings.currencies: 'العملات',
  AppStrings.currency: 'العملة',

  ///... biometric and biometric authentication
  AppStrings.biometric: 'البصمة',
  AppStrings.enableBiometricLogin: 'تمكين تسجيل الدخول بالبصمة',
  // AppStrings.loginUsingBiometric: 'تسجيل الدخول باستخدام البصمة',
  AppStrings.authentication: 'المصادقة',
  AppStrings.biometricAuthentication: 'المصادقة بالبصمة الحيوية',
  // AppStrings.biometricAuthenticationFailed: 'فشلت المصادقة',
  AppStrings.biometricMessage: 'تسجيل الدخول بواسطة بصمة الإصبع أو الوجه',
  AppStrings.scanYourFingerprint: ' بصمة الإصبع',
  // AppStrings.skip: 'تجاوز',
  // AppStrings.loginInstead: 'تسجيل الدخول',
  // AppStrings.poweredBy: 'مدعوم بواسطة',
  AppStrings.chooseAuthenticationMethod: 'أختر طريقة المصادقة',
  AppStrings.enableBiometricAuthFromSettingsFirst:
      'قم بتفعيل الدخول بالبصمة من الإعدادات',
  AppStrings.notSupportBiometricMessage: 'لا يدعم هاتفك البصمة',
  // AppStrings.jailBrokenMessage: 'لا يمكنك تسجيل الحضور من جهاز (Jailbroken)',
  // AppStrings.canMockLocationMessage: 'لا يمكنك تسجيل الحضور من موقع وهمي',
  // AppStrings.isRealDeviceMessage: 'يمكنك تسجيل الحضور بجهاز حقيقي فقط',
  // AppStrings.isOnExternalStorageMessage:
  // 'يجب أن يتم تخزين التطبيق في الذاكرة الداخلية',

  ///... global Strings .........................................
  AppStrings.goodMorning: 'صباح الخير',
  AppStrings.goodAfternoon: 'طاب مساؤك',
  AppStrings.goodEvening: 'مساء الخير',
  AppStrings.search: 'بحث',
  AppStrings.failed: 'فشل',
  AppStrings.success: 'نجاح',
  AppStrings.attention: 'تنبيه',
  AppStrings.successfullyDone: 'تم بنجاح',
  AppStrings.noMoreItem: 'لا يوجد المزيد من العناصر ',
  AppStrings.delete: 'حذف',
  // AppStrings.noValue: 'لا توجد قيمة',
  AppStrings.continu: 'استمرار',
  AppStrings.selectImageSource: 'اختر مصدر الصورة',
  AppStrings.pleaseWait: 'يرجى الانتظار',

  AppStrings.add: 'اضافة',
  // MamaMiaAppStrings.back: 'رجوع',
  AppStrings.cancel: 'الغاء',
  AppStrings.aboutApp: 'عن التطبيق',
  AppStrings.no: 'لا',
  AppStrings.yes: 'نعم',
  AppStrings.ok: 'نعم',
  AppStrings.submit: 'إرسال',
  AppStrings.retry: 'اعادة المحاولة',
  AppStrings.confirmAndSend: 'تأكيد وإرسال',
  AppStrings.loading: 'جار جلب البيانات',
  AppStrings.pickImage: 'اختر صورة',
  AppStrings.gallery: 'معرض',
  AppStrings.camera: 'كاميرا',
  AppStrings.noDataFound: 'لاتوجد بيانات',
  AppStrings.contactUs: 'التواصل معنا',

  /// warning Strings
  ApiErrorsStrings.someThingWentWrong: "حدث خطأ غير متوقع",
  ApiErrorsStrings.unexpectedErrorOccurred: "حدث خطأ غير متوقع",
  ApiErrorsStrings.wrongEmailOrPassword: 'بريد إلكتروني أو كلمة مرور خاطئة',
  AppStrings.areYouSureYouWantToLogOut: "هل أنت متأكد أنك تريد تسجيل الخروج",
  // NLFAppStrings.youNeedToLoggedInToContinue: 'يجب عليك تسجيل الدخول للاستمرار ',
  ApiErrorsStrings.unauthorizedToAccessThisApp:
      'هذا المستخدم غير مصرح له بالوصول إلى هذه الصفحة',
  ApiErrorsStrings.errorsInConnection: 'خطأ في الاتصال بالإنترنت',
  ApiErrorsStrings.tryAgain: 'اعادة المحاولة',
  ApiErrorsStrings.noChangeMessage: 'لم تتغير أي بيانات',
  ApiErrorsStrings.internetConnectionError: 'خطأ في الاتصال بالإنترنت',
  ApiErrorsStrings.checkInternet: 'يرجى التاكد من اتصالك بالانترنت',
  ApiErrorsStrings.youMayHaveBadInternetConnection:
      'قد يكون لديك اتصال إنترنت سيئ',

  AppStrings.error: 'خطأ',
  ApiErrorsStrings.urlPageNotFound: 'هذة الصفحة غير موجودة',
  ApiErrorsStrings.userNotFound: 'المستخدم غير موجود',
  ApiErrorsStrings.serverCanNotReachedItMayBeUnderMaintenance:
      'تعذر الوصول إلى السرفر ، قد يكون السرفر قيد الصيانة',

  AppStrings.openFileError: 'لا يمكنك فتح الملف',
  AppStrings.makeCallError: 'لا يمكنك إجراء إتصال',
  AppStrings.openEmailError: 'لا يمكنك فتح الايميل',
  AppStrings.whatsappNotInstalled: 'الوتساب غير مثبت في جهازك',

  ///.. profile
  AppStrings.title: 'الاسم',
  AppStrings.description: 'الوصف',
  AppStrings.quantity: 'الكمية',
  // AppStrings.photos: 'الصور',
  // AppStrings.videos: 'الفيديو',
  // AppStrings.pickImages: 'اختر الصور',
  // AppStrings.pickVideo: 'اختر الفيديو',

  AppStrings.sortBy: 'ترتيب حسب',

  AppStrings.applyFilter: 'تطبيق',
  AppStrings.resetFilter: 'إعادة تعيين',
  AppStrings.filterAndSearch: 'التصفية والبحث',

  ///.. profile screen
  AppStrings.name: 'الاسم:',
  // AppStrings.displayName: 'الاسم:',
  // AppStrings.underWaitingForAdminApprove: 'طلبك قيد انتظار موافقة المسؤول',

  ///..
  AppStrings.imageGallery: 'معرض الصور',
  AppStrings.noUrlAvailable: 'لا يوجد رابط',

  AppStrings.confirmationDefaultMessage: 'هل أنت متأكد أنك تريد القيام بذلك؟',
  AppStrings.invalidDocUrl: 'عنوان url غير صالح',

  ///... profile view
  AppStrings.profile: 'الملف الشخصي',
  // AppStrings.details: 'التفاصيل',

  ///.........................................................
  AppStrings.thisActionWillChangeThePriceOfProductsInto:
      'سيؤدي هذا الإجراء إلى تغيير سعر المنتجات إلى',
  AppStrings.pleaseUpdateYourAppToContinueWithThis:
      'يرجى تحديث التطبيق الخاص بك للمواصلة',

  ///.. global strings
  AppStrings.fillRequireDataFieldsBellow:
      'يرجى ملء حقول البيانات المطلوبة أدناه',
  AppStrings.successfullyCopyToClipboard: 'تم النسخ إلى الحافظة بنجاح',

  AppStrings.about: "عنا",

  AppStrings.noItems: 'لا توجد عناصر',

  AppStrings.update: 'تحديث',
  AppStrings.edit: 'تعديل',

  ///..

  AppStrings.thisMediaScreenNotSupported:
      'شاشة الوسائط هذه غير مدعومة، يرجى فتح هذا التطبيق في شاشة أخرى.',

  AppStrings.way: 'الطريقة',
  // AppStrings.completedTab: 'COMPLETED',
  AppStrings.paymentInfo: 'معلومات الدفع',
  AppStrings.pleaseSelectYourPreferredShippingMethod:
      'يرجى اختيار طريقة الشحن المفضلة لديك',
  AppStrings.selectQuantity: 'حدد الكمية',
  AppStrings.noSubCat: 'لا توجد فئات فرعية',
  AppStrings.filterByManufacturer: 'تصفية بحسب الشركة المصنعة',
  AppStrings.attributes: 'الصفات',
  AppStrings.enterYourCustomPrice: 'أدخل السعر الخاص بك',
  AppStrings.availableShippingEstimation: 'تقديرات الشحن المتاحة',
  AppStrings.typeWhatAreLookingFor: 'اكتب ما تبحث عنه للبدء',
  AppStrings.showMore: 'أظهار المزيد',
  AppStrings.showLess: 'عرض أقل',
  AppStrings.later: 'لاحقاً',
  AppStrings.grant: 'منح',
  AppStrings.manageStorage: 'الوصول للتخزين',
  AppStrings.manageExternalStorageExplain:
      'يتطلب هذا التطبيق الوصول إلى وحدة التخزين لمواصلة تنزيل الملفات.',
  AppStrings.orderDetails: 'تفاصيل الطلب',
  AppStrings.shippingStatus: 'حالة الشحن',
  AppStrings.paymentStatus: 'حالة الدفع',
};
