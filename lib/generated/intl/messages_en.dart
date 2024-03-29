// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(provider) => "Login With ${provider}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "copyCreateAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "copyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Alredy have an account?"),
        "copyResetPassword":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "labelEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "labelLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "labelPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "labelReset": MessageLookupByLibrary.simpleMessage("Reset"),
        "labelSend": MessageLookupByLibrary.simpleMessage("Send"),
        "labelSignOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "labelSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "labelUserName": MessageLookupByLibrary.simpleMessage("Name"),
        "loginWith": m0,
        "newPacient":
            MessageLookupByLibrary.simpleMessage("N E W    P A C I E N T"),
        "pacientsList":
            MessageLookupByLibrary.simpleMessage("P A C I E N T S     L I S T"),
        "submit": MessageLookupByLibrary.simpleMessage("SUBMIT")
      };
}
