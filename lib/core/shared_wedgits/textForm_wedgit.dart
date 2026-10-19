import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextformWedgit extends StatefulWidget {
  final String hintT;
   final bool isPass;
   final String ?Function(String?)? validator;
   final TextEditingController controller;
   const TextformWedgit({required this.controller, this.validator,this.isPass=false,required this.hintT,super.key});

  @override
  State<TextformWedgit> createState() => _TextformWedgitState();
}

class _TextformWedgitState extends State<TextformWedgit> {
  bool isObsecure =true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onTapOutside: (v){
        FocusScope.of(context).unfocus();
      },
      cursorColor: AppColors.mainColor,
      obscureText: widget.isPass&&isObsecure,
      
      decoration: InputDecoration(
        suffixIcon: widget.isPass?InkWell(
          onTap: (){
            setState(() {
              isObsecure=!isObsecure;
            });

          },
          child: Icon(Icons.visibility)):null,
        fillColor: Colors.white70,
        filled: true,
        hintStyle: AppTextstyle.hintTextStyle,
        hintText:widget.hintT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.borderColor,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.borderColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.mainColor,
          )
        ),
      ),
    );
  }
}