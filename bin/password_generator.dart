/// password_generator.dart
///
/// Generates a complex password using Dart 2.14.
/// Author: Arnaud Ralec

import 'dart:math';

const String _specialCharacters = "@#-_!?&";
const String _alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
const String _digits = "0123456789";

/// Renders a stream of bits suitable for a cryptographic use.
Random rndGenerator = Random.secure();

class PasswordSizeError implements Exception {
  String message = "A valid password must contain at least 8 characters.";

  @override
  String toString() {
    return message;
  }
}

/// Generates a random password containing special characters and digits.
String passwordGenerator({int size = 10}) {
  try {
    if (size >= 8) {
      List letters = List.generate(
          size ~/ 2, // Using a truncating division in order to get an int.
          (value) => String.fromCharCode(
              _alphabet.codeUnitAt(rndGenerator.nextInt(_alphabet.length))));

      List digits = List.generate(
          size ~/ 8,
          (value) => String.fromCharCode(
              _digits.codeUnitAt(rndGenerator.nextInt(_digits.length))));

      List sChars = List.generate(
          size ~/ 8,
          (value) => String.fromCharCode(_specialCharacters
              .codeUnitAt(rndGenerator.nextInt(_specialCharacters.length))));

      List pwd = (digits + letters + sChars);
      pwd.shuffle();

      return pwd.join();
    } else {
      throw PasswordSizeError();
    }
  } catch (e) {
    return e.toString();
  }
}

void main() {
  String pwd = passwordGenerator();
  print(pwd);
}
