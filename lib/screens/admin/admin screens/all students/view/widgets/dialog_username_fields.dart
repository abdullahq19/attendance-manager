import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';

class BottomSheetUsernameFields extends StatelessWidget {
  const BottomSheetUsernameFields(
      {super.key,
      required this.width,
      required this.firstNameController,
      required this.lastNameController});

  final double width;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyTextFormField(
            textFieldWidth: width * 0.45,
            controller: firstNameController,
            hintText: 'John',
            label: 'First name',
            keyboardType: TextInputType.name,
            validator: (firstName) {
              if (firstName == null || firstName.isEmpty) {
                return 'Enter your first name';
              } else {
                return firstName.validateUserName();
              }
            },
          ),
          MyTextFormField(
            textFieldWidth: width * 0.45,
            controller: lastNameController,
            hintText: 'Doe',
            label: 'Last name',
            keyboardType: TextInputType.name,
            validator: (lastName) {
              if (lastName == null || lastName.isEmpty) {
                return 'Enter your last name';
              } else {
                return lastName.validateUserName();
              }
            },
          ),
        ],
      ),
    );
  }
}
