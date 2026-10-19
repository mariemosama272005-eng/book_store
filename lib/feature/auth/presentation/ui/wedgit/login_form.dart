import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/shared_wedgits/textForm_wedgit.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/core/util/App_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
       
        children: [
          TextformWedgit(hintT: "email".tr(),validator: (v) {
            if(v==null||v.isEmpty){
              return"emailRe".tr();
            }
            if(!AppValidator.isValidEmail(v)){
return"validEmail".tr();

            }
          
            
          },),
          15.verticalSpace,
          TextformWedgit(hintT: "pass".tr(),isPass: true,validator: (v) {
            if(v==null||v.isEmpty){
              return"passReq".tr();
            }
            if(!AppValidator.isPasswordValid(v)){
return"validPass".tr();

            }
            }),
            Align(
alignment: Alignment.centerRight,
              child: InkWell(child: Text("forgetpass".tr(),style: AppTextstyle.hintTextStyle,),
              onTap: (){
              
                         Navigator.pushNamed(context, AppRoutes.forgetpassScreen);
              
                       
                      },
                        
              ),
            ),
            30.verticalSpace,
            MainbuttonWedgit(title: "login".tr(),onTap: 
            (){
              formState.currentState?.validate();
            },),

        ],
      ),
    );
  }
}