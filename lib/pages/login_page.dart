import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/features/blocs/Authen/authen_bloc.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/resgister_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

import 'chat_page.dart';
//static String id = 'login page';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static String id = 'login page';
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenBloc, AuthenState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailureState) {
          showSnackBar(context, state.message);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButon(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenBloc>(context).add(
                              LoginUser(email: email!, password: password!));
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dont\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
