import 'package:figure_skating_jumps/constants/lang_fr.dart';
import 'package:figure_skating_jumps/exceptions/ice_exception.dart';

class WeakPasswordException implements IceException {
  @override
  String get devMessage {
    return "The password isn't strong enough.";
  }

  @override
  String get uiMessage {
    return weakPasswordException;
  }
}
