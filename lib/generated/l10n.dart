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

  /// `Do you alredy have an account?`
  String get copyHaveAccount {
    return Intl.message(
      'Do you alredy have an account?',
      name: 'copyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Can not remember your password?`
  String get copyResetPassword {
    return Intl.message(
      'Can not remember your password?',
      name: 'copyResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't you have an account?`
  String get copyCreateAccount {
    return Intl.message(
      'Don\'t you have an account?',
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

  /// `FullName`
  String get fullName {
    return Intl.message(
      'FullName',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Identification Number`
  String get id {
    return Intl.message(
      'Identification Number',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Date of Bird`
  String get date {
    return Intl.message(
      'Date of Bird',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Basic`
  String get basic {
    return Intl.message(
      'Basic',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `grid`
  String get grid {
    return Intl.message(
      'grid',
      name: 'grid',
      desc: '',
      args: [],
    );
  }

  /// `facial`
  String get facial {
    return Intl.message(
      'facial',
      name: 'facial',
      desc: '',
      args: [],
    );
  }

  /// `Change subscription`
  String get changeSubscrip {
    return Intl.message(
      'Change subscription',
      name: 'changeSubscrip',
      desc: '',
      args: [],
    );
  }

  /// `Select a photo:`
  String get selectPhoto {
    return Intl.message(
      'Select a photo:',
      name: 'selectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Select another photo:`
  String get selectAnotherPhoto {
    return Intl.message(
      'Select another photo:',
      name: 'selectAnotherPhoto',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any patients yet`
  String get titleCreatePasient {
    return Intl.message(
      'You don\'t have any patients yet',
      name: 'titleCreatePasient',
      desc: '',
      args: [],
    );
  }

  /// `for create your first patient please press 'Create' button`
  String get copyCreatePasient {
    return Intl.message(
      'for create your first patient please press \'Create\' button',
      name: 'copyCreatePasient',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Delete {item}?`
  String titleDelete(Object item) {
    return Intl.message(
      'Delete $item?',
      name: 'titleDelete',
      desc: '',
      args: [item],
    );
  }

  /// `This action cannot be undone`
  String get copyDelete {
    return Intl.message(
      'This action cannot be undone',
      name: 'copyDelete',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message(
      'Patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{Photo} other{Photos}}`
  String textWithPlural(num howMany) {
    return Intl.plural(
      howMany,
      one: 'Photo',
      other: 'Photos',
      name: 'textWithPlural',
      desc: '',
      args: [howMany],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
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
