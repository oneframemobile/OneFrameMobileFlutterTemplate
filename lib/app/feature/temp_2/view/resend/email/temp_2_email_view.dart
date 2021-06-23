import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/base/view/widgets/button/raised_gradient_button.dart';
import '../../../../../core/base/view/widgets/container/space.dart';
import '../../../../../core/base/view/widgets/text/input_text.dart';
import '../../../../../core/base/view/widgets/text/title_text.dart';
import '../../../../../core/style/app_color.dart';
import '../../../../../core/style/app_text_style.dart';
import '../../../../../core/translation/localization_key.dart';
import '../../../../../core/util/ui_helper.dart';
import '../../../controller/resend/email/temp_2_email_controller.dart';

class Temp2EmailView extends GetView<Temp2EmailController> {
  final controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          LocalizationKey.RenewPasswordWithEmail.tr,
          style: titleNormalTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: UIHelper.Space50.w),
        child: Column(
          children: <Widget>[
            TitleText(
              title: LocalizationKey.RenewPasswordWithEmail.tr,
              description:
                  "Lorem ipsum dolor sit amet, consetetursadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea",
              titleStyle: titleNormalTextStyle,
            ),
            Space(height: UIHelper.Space600.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UIHelper.Space60.w),
              child: InputText(
                labelText: LocalizationKey.Email.tr,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
            ),
            Space(height: UIHelper.Space300.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UIHelper.Space60.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: RaisedGradientButton(
                  height: UIHelper.Space300.h,
                  leftIcon: Icons.mail_outline,
                  child: Text(LocalizationKey.SendEmail.tr,
                      style: loginButtonStyle),
                  gradient: LinearGradient(
                    colors: forgotEMailButtonGradient,
                  ),
                  onPressed: controller.emailTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}