// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `P A C I E N T S     L I S T`
  String get pacientsList {
    return Intl.message(
      'P A C I E N T S     L I S T',
      name: 'pacientsList',
      desc: '',
      args: [],
    );
  }

  /// `N E W    P A C I E N T`
  String get newPacient {
    return Intl.message(
      'N E W    P A C I E N T',
      name: 'newPacient',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get labelLogin {
    return Intl.message(
      'Login',
      name: 'labelLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get labelSignOut {
    return Intl.message(
      'Sign Out',
      name: 'labelSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelEmail {
    return Intl.message(
      'Email',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get labelReset {
    return Intl.message(
      'Reset',
      name: 'labelReset',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get labelSignUp {
    return Intl.message(
      'Sign Up',
      name: 'labelSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get labelSend {
    return Intl.message(
      'Send',
      name: 'labelSend',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelUserName {
    return Intl.message(
      'Name',
      name: 'labelUserName',
      desc: '',
      args: [],
    );
  }

  /// `Alredy have an account?`
  String get copyHaveAccount {
    return Intl.message(
      'Alredy have an account?',
      name: 'copyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get copyResetPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'copyResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get copyCreateAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'copyCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login With {provider}`
  String loginWith(Object provider) {
    return Intl.message(
      'Login With $provider',
      name: 'loginWith',
      desc: '',
      args: [provider],
    );
  }

  /// `SUBMIT`
  String get submit {
    return Intl.message(
      'SUBMIT',
      name: 'submit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
