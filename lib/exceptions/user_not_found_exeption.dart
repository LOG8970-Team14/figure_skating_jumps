import 'package:figure_skating_jumps/constants/lang_fr.dart';
import 'package:figure_skating_jumps/exceptions/ice_exception.dart';

class UserNotFoundException implements IceException {
  @override
  String get devMessage {
    return "User has not been found.";
  }

  @override
  String get uiMessage {
    return userNotFoundExeption;
  }
}
