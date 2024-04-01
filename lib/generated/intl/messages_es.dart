// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(provider) => "Iniciar sesión ${provider}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "advanced": MessageLookupByLibrary.simpleMessage("Avanzado"),
        "age": MessageLookupByLibrary.simpleMessage("Edad"),
        "basic": MessageLookupByLibrary.simpleMessage("Basico"),
        "changeSubscrip":
            MessageLookupByLibrary.simpleMessage("Modificar suscripción"),
        "copyCreateAccount":
            MessageLookupByLibrary.simpleMessage("¿No tienes una cuenta?"),
        "copyHaveAccount":
            MessageLookupByLibrary.simpleMessage("¿Ya tienes una cuenta?"),
        "copyResetPassword":
            MessageLookupByLibrary.simpleMessage("¿Olvidaste tu contraseña?"),
        "date": MessageLookupByLibrary.simpleMessage("Fecha de Nacimiento"),
        "fullName": MessageLookupByLibrary.simpleMessage("Nombre Completo"),
        "id": MessageLookupByLibrary.simpleMessage("Número Identificación"),
        "labelEmail": MessageLookupByLibrary.simpleMessage("Correo"),
        "labelLogin": MessageLookupByLibrary.simpleMessage("Ingreso"),
        "labelPassword": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "labelReset": MessageLookupByLibrary.simpleMessage("Restablecer"),
        "labelSend": MessageLookupByLibrary.simpleMessage("Enviar"),
        "labelSignOut": MessageLookupByLibrary.simpleMessage("Cerrar Sesión"),
        "labelSignUp": MessageLookupByLibrary.simpleMessage("Crear"),
        "labelUserName": MessageLookupByLibrary.simpleMessage("Nombre"),
        "loginWith": m0,
        "newPacient":
            MessageLookupByLibrary.simpleMessage("N U E V O   P A C I E N T E"),
        "pacientsList": MessageLookupByLibrary.simpleMessage(
            "L I S T A    D E    P A C I E N T E S"),
        "submit": MessageLookupByLibrary.simpleMessage("Confirmar")
      };
}
