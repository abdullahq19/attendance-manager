import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key, required this.height, required this.width});

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AppCommonButton(
        onPressed: () => Navigator.of(context).pop(),
        width: width,
        height: height,
        color: AppColors.blue50,
        child: Text('<- Go Back ', style: Theme.of(context).textTheme.titleSmall,),
      ),
    );
  }
}
