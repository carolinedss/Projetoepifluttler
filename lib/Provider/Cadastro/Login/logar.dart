import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projetoepi/Constrain/url.dart';
import 'package:http/http.dart' as http;

class Logar extends ChangeNotifier {
  bool _valido = false;
  bool _logado = false;
  String _msgError = '';

  bool get ehvalido => _valido;
  bool get logado => _logado;
  String get msgError => _msgError;

  void validatePassword(String password){
    _msgError = '';
    if (password.length < 8){
      _msgError = 'Mínimo 8 digitos';
    }else if (!password.contains(RegExp(r'[a-z]'))) {
      _msgError = 'Pelo menos uma letra minúscula ';
    }
      else if (!password.contains(RegExp(r'[a-z]'))) {
      _msgError = 'Pelo menos uma letra maiúscula  ';
    }
    else if (!password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:\|,.<>\/?]'))){
      _msgError = 'Pelo menos um carácter especial';
    }
    else if (!password.contains(RegExp(r'[0-9]'))) {
      _msgError = 'Pelo menos um número';
    }

    _valido = _msgError.isEmpty;
    notifyListeners();
  }

  Future logarUsuario(String email, String password, int cpf) async{
    String url = '${AppUrl.baseUrl}api/Usuario/Login';
    debugPrint(url);

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'cpf': cpf,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200){
      _logado = true;
      notifyListeners();
    } else{
      _logado = false;
      notifyListeners();
    }
  }
}