import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width) = MediaQuery.sizeOf(context);
    return Row(
      children: [
        Expanded(
            child: Divider(
                color: AppColors.grey,
                indent: width * 0.05,
                endIndent: width * 0.05)),
        const Text('Or'),
        Expanded(
            child: Divider(
          color: AppColors.grey,
          indent: width * 0.05,
          endIndent: width * 0.05,
        )),
      ],
    );
  }
}
