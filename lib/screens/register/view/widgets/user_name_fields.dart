import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';

class UserNamefields extends StatelessWidget {
  const UserNamefields(
      {super.key,
      required this.firstNameController,
      required this.lastNameController});

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    final Size(:width) = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextFormField(
            textFieldWidth: width * 0.5,
            controller: firstNameController,
            keyboardType: TextInputType.name,
            validator: (firstName) {
              if (firstName == null || firstName.isEmpty) {
                return 'Enter your first name';
              } else {
                return firstName.validateUserName();
              }
            },
            hintText: 'John',
            label: 'First Name'),
        MyTextFormField(
            textFieldWidth: width * 0.5,
            controller: lastNameController,
            keyboardType: TextInputType.name,
            validator: (lastName) {
              if (lastName == null || lastName.isEmpty) {
                return 'Enter your last name';
              } else {
                return lastName.validateUserName();
              }
            },
            hintText: 'Doe',
            label: 'Last Name'),
      ],
    );
  }
}
