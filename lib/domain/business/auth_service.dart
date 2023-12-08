import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? userAuth;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  void _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      userAuth = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  void _getUser() {
    userAuth = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado!');
      } else {
        throw AuthException("Erro desconhecido: ${e.code}");
      }
    }
    return null;
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw AuthException("O e-mail não está cadastrado.");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta.");
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException('Email ou senha inválidos!');
      } else if (e.code == 'too-many-requests') {
        throw AuthException('Muitas tentativas, aguarde!');
      } else {
        throw AuthException("Erro desconhecido: ${e.code}");
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _getUser();
  }
}
