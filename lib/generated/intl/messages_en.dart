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

  static String m1(item) => "Delete ${item}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "advanced": MessageLookupByLibrary.simpleMessage("advanced"),
        "age": MessageLookupByLibrary.simpleMessage("Age"),
        "basic": MessageLookupByLibrary.simpleMessage("Basic"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeSubscrip":
            MessageLookupByLibrary.simpleMessage("Change subscription"),
        "copyCreateAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t you have an account?"),
        "copyCreatePasient": MessageLookupByLibrary.simpleMessage(
            "for create your first patient please press \'Create\' button"),
        "copyDelete": MessageLookupByLibrary.simpleMessage(
            "This action cannot be undone"),
        "copyHaveAccount": MessageLookupByLibrary.simpleMessage(
            "Do you alredy have an account?"),
        "copyResetPassword": MessageLookupByLibrary.simpleMessage(
            "Can not remember your password?"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "date": MessageLookupByLibrary.simpleMessage("Date of Bird"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "fullName": MessageLookupByLibrary.simpleMessage("FullName"),
        "id": MessageLookupByLibrary.simpleMessage("Identification Number"),
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
        "patient": MessageLookupByLibrary.simpleMessage("Patient"),
        "photo": MessageLookupByLibrary.simpleMessage("Photo"),
        "selectAnotherPhoto":
            MessageLookupByLibrary.simpleMessage("Select another photo:"),
        "selectPhoto": MessageLookupByLibrary.simpleMessage("Select a photo:"),
        "submit": MessageLookupByLibrary.simpleMessage("SUBMIT"),
        "titleCreatePasient": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any patients yet"),
        "titleDelete": m1
      };
}
