bool validateEmail(String email) {
  if (email != null) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

bool confirmPass(String pass1, String pass2) {
  if (pass1 != null && pass2 != null) {
    if (pass1 == pass2) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

bool checkPass(String pass) {
  if (pass == null || pass.length < 8) {
    return false;
  } else {
    return true;
  }
}

bool checkEmpty(String val) {
  if (val != null) {
    return true;
  }
  return false;
}
