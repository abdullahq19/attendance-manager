extension Validation on String {
  String? validateEmail() {
    if (contains(RegExp(r'[A-Z]'))) {
      return 'Email cannot contain a capital letter';
    } else if (!contains('@')) {
      return 'Email should contain @';
    } else if (contains('@') && !contains('.')) {
      return 'Email should contain "."';
    } else if (contains('@') && contains('.') && endsWith('.')) {
      return 'Please write a valid domain name';
    }
    return null;
  }

  String? validatePassword() {
    if (length < 8) {
      return 'Password length should 8 or more';
    } else if (!contains(RegExp(r'[A-Z]'))) {
      return 'Password should contain a capital letter A-Z';
    } else if (!contains(RegExp(r'[0-9]'))) {
      return 'Password should contain a number 0-9';
    }
    return null;
  }

  String? validateUserName() {
    if (isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }
}
