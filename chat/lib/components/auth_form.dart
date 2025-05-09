import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm(this.onSubmit);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  _handleImagePick(File image) {
    _formData.image = image;
  }
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
      )
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup) UserImagePicker(onImagePick: _handleImagePick,),
              if (_formData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (name) => _formData.name = name,
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _formData.email,
                decoration: InputDecoration(labelText: 'E-mail'),
                onChanged: (email) => _formData.email = email,
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail informado não é válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: ValueKey('passoword'),
                obscureText: true,
                initialValue: _formData.passowrd,
                decoration: InputDecoration(labelText: 'Senha'),
                onChanged: (passowrd) => _formData.passowrd = passowrd,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
