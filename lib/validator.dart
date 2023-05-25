class Validator {
  bool validateName({required String? name}) {
    if (name == null) return false;
    RegExp nameExp = RegExp(r"^[a-zA-Z ]{4,}[a-zA-Z]+$");
    if (!nameExp.hasMatch(name)) {
      return false;
    } //"Enter a correct name"

    if (name.split(" ").length != 2) {
      return false;
    } // "You must right your first name and last name"

    if (name.isEmpty) {
      return false;
    } // 'Name can\'t be empty'
    return true;
  }

  bool validateEmail({required String? email}) {
    if (email == null) return false;
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    if (email.isEmpty) {
      return false; //'Email can\'t be empty'
    } else if (!emailRegExp.hasMatch(email)) {
      return false; //'Enter a correct email'
    }

    return true;
  }

  bool validatePassword({required String? password}) {
    if (password == null) return false;
    RegExp passwordReg = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$");
    if (!passwordReg.hasMatch(password)) return false;
    return true;
  }

  bool verifyPassword({required String? p1, required String? p2}) {
    if (p1 == null || p2 == null) return false;
    if (p1 != p2) return false;
    return true;
  }

  bool validatePhone({required String? phone}) {
    if (phone == null) return false;
    RegExp phoneReg = RegExp(r"^05\d{8}$");
    if (!phoneReg.hasMatch(phone)) return false;
    return true;
  }

  bool validateDate({required DateTime date}) {
    int ceilYear = DateTime.now().year;
    int floorYear = ceilYear - 100;

    if (date.year < ceilYear && date.year > floorYear) return true;
    return false;
  }

  

}
