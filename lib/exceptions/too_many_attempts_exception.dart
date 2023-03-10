import 'package:figure_skating_jumps/constants/lang_fr.dart';
import 'package:figure_skating_jumps/exceptions/ice_exception.dart';

class TooManyAttemptsException implements IceException {
  @override
  String get devMessage {
    return "We have blocked all requests from this device due to unusual activity.";
  }

  @override
  String get uiMessage {
    return tooManyAttemptsException;
  }
}
