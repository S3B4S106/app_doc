// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(provider) => "Entrar com ${provider}";

  static String m1(item) => "Deletar ${item}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "advanced": MessageLookupByLibrary.simpleMessage("avançado"),
        "age": MessageLookupByLibrary.simpleMessage("Idade"),
        "basic": MessageLookupByLibrary.simpleMessage("básico"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "changeSubscrip":
            MessageLookupByLibrary.simpleMessage("Modificar inscrição"),
        "copyCreateAccount":
            MessageLookupByLibrary.simpleMessage("Não tem uma conta?"),
        "copyCreatePasient": MessageLookupByLibrary.simpleMessage(
            "para criar seu primeiro paciente, pressione o botão \'Criar\'"),
        "copyDelete": MessageLookupByLibrary.simpleMessage(
            "Essa ação não pode ser desfeita"),
        "copyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Já tem uma conta?"),
        "copyResetPassword":
            MessageLookupByLibrary.simpleMessage("Esqueceu sua senha?"),
        "create": MessageLookupByLibrary.simpleMessage("Criar"),
        "date": MessageLookupByLibrary.simpleMessage("Data de Nascimento"),
        "delete": MessageLookupByLibrary.simpleMessage("Deletar"),
        "fullName": MessageLookupByLibrary.simpleMessage("Nome Completo"),
        "id": MessageLookupByLibrary.simpleMessage("Número de Identificação"),
        "labelEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "labelLogin": MessageLookupByLibrary.simpleMessage("Entrar"),
        "labelPassword": MessageLookupByLibrary.simpleMessage("Senha"),
        "labelReset": MessageLookupByLibrary.simpleMessage("Redefinir"),
        "labelSend": MessageLookupByLibrary.simpleMessage("Enviar"),
        "labelSignOut": MessageLookupByLibrary.simpleMessage("Sair"),
        "labelSignUp": MessageLookupByLibrary.simpleMessage("Registrar-se"),
        "labelUserName":
            MessageLookupByLibrary.simpleMessage("Nome de Usuário"),
        "loginWith": m0,
        "newPacient":
            MessageLookupByLibrary.simpleMessage("N O V O   P A C I E N T E"),
        "pacientsList": MessageLookupByLibrary.simpleMessage(
            "L I S T A    D E    P A C I E N T E S"),
        "patient": MessageLookupByLibrary.simpleMessage("Paciente"),
        "photo": MessageLookupByLibrary.simpleMessage("Foto"),
        "selectAnotherPhoto":
            MessageLookupByLibrary.simpleMessage("Selecione outra foto:"),
        "selectPhoto":
            MessageLookupByLibrary.simpleMessage("Selecione uma foto:"),
        "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
        "titleCreatePasient": MessageLookupByLibrary.simpleMessage(
            "Você ainda não tem nenhum paciente"),
        "titleDelete": m1
      };
}
