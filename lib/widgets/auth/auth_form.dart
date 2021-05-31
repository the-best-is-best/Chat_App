import 'dart:math';

import 'package:chat_app/models/auth_model.dart';
import '/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, 80), 0);
    return Container(
      child: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, bottom),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (context.watch<AuthModel>().isLogin != true) ...{
                      Container(
                        child: (context.watch<AuthModel>().isLogin)
                            ? null
                            : UserImagePicker(),
                      ),
                    },
                    SizedBox(height: 12),
                    Container(
                      height: 70,
                      child: TextFormField(
                        key: ValueKey('email'),
                        autocorrect: false,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 16.0),
                          icon: Icon(
                            Icons.email,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        validator: (val) {
                          if (val!.isEmpty || !val.contains('@')) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onChanged: (val) =>
                            context.read<AuthModel>().addEmail(val),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: context.watch<AuthModel>().opacityContainer,
                      duration: Duration(milliseconds: 500),
                      child: AnimatedContainer(
                        height: context.watch<AuthModel>().heightContainer,
                        duration: Duration(milliseconds: 500),
                        child: (context.watch<AuthModel>().isLogin)
                            ? null
                            : TextFormField(
                                key: ValueKey('username'),
                                autocorrect: true,
                                enableSuggestions: false,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  icon: Icon(Icons.person),
                                  labelText: 'Username',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                validator: (val) {
                                  if (val!.isEmpty || val.length < 4) {
                                    return "Please enter at least 4 character";
                                  }
                                  return null;
                                },
                                onChanged: (val) =>
                                    context.read<AuthModel>().addUsername(val),
                                keyboardType: TextInputType.text,
                              ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 70,
                      child: TextFormField(
                        key: ValueKey('password'),
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 16.0),
                          icon: Icon(Icons.password),
                          suffixIcon: TextButton.icon(
                            onPressed: () => context
                                .read<AuthModel>()
                                .addIsPasswordVisible(),
                            icon:
                                context.watch<AuthModel>().isPasswordNotVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                            label: Text(''),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        validator: (val) {
                          if (val!.isEmpty || val.length < 7) {
                            return "Password must be at least 7 characters";
                          }
                          return null;
                        },
                        onChanged: (val) =>
                            context.read<AuthModel>().addPassword(val),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText:
                            context.watch<AuthModel>().isPasswordNotVisible,
                      ),
                    ),
                    SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: context.watch<AuthModel>().opacityContainer,
                      duration: Duration(milliseconds: 500),
                      child: AnimatedContainer(
                        height: context.watch<AuthModel>().heightContainer,
                        duration: Duration(milliseconds: 500),
                        child: TextFormField(
                          key: ValueKey('again_password'),
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            labelText: 'Verify Password',
                            labelStyle: TextStyle(fontSize: 16.0),
                            icon: Icon(Icons.password),
                            suffixIcon: TextButton.icon(
                              onPressed: () => context
                                  .read<AuthModel>()
                                  .addIsPasswordVisible(),
                              icon: context
                                      .watch<AuthModel>()
                                      .isPasswordNotVisible
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              label: Text(''),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (val) {
                            if (val!.isEmpty ||
                                val != context.read<AuthModel>().password) {
                              return "Password not the same";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:
                              context.watch<AuthModel>().isPasswordNotVisible,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    if (context.watch<AuthModel>().isLoading) ...{
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                    },
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.green,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      onPressed: () =>
                          context.read<AuthModel>().sumbit(context, _fromKey),
                      child: Text(context.read<AuthModel>().isLogin
                          ? "Login"
                          : "Sign Up"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthModel>().switchLogin();
                        context.read<AuthModel>().addheightContainer();
                        context.read<AuthModel>().addopacityContainer();
                      },
                      child: Text(context.watch<AuthModel>().isLogin
                          ? "Create new Account"
                          : "I Already have an accont"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
