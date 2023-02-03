import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/form_submission_status.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_state.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_state.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/group_home_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/sign_up_screen.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _loginFormController = TextEditingController();
  final _passwordFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _signInForm();
  }

  Widget _signInForm() {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      final formStatus = state.formStatus;

      if (formStatus is SubmissionFailed) {
        print('fail');
        _showSnackBar(context, formStatus.exeption.toString());
      } else if (state.formStatus is SubmitionSucces) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupHomeScreen(
                      name: _loginFormController.text,
                    )));
      }
    }, builder: (context, state) {
      return Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80, top: 50, left: 30),
              child: Column(children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 35,
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Sign in to continue',
                  style:
                      TextStyle(fontSize: 20, color: AppColors.helpTextColor),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _loginField(),
                  SizedBox(height: 10),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _passwordField(),
                  SizedBox(height: 100),
                  _signinButton(),
                ],
              ),
            ),
          ]));
    });
  }

  Widget _loginField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: ((context, state) {
        return TextFormField(
          controller: _loginFormController,
          decoration: textFieldDecoration(),
          validator: (value) =>
              state.isValidUsername ? null : 'Username is too short',
          onChanged: ((value) => context.read<LoginBloc>().add(
                LoginUsernameChanged(_loginFormController.text),
              )),
        );
      }),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
      return TextFormField(
        controller: _passwordFormController,
        obscureText: true,
        decoration: textFieldDecoration(),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is to short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(_passwordFormController.text),
            ),
      );
    }));
  }

  Widget _signinButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted(
                          SignInModel(
                              login: _loginFormController.text,
                              password: _passwordFormController.text),
                        ));
                  }
                },
                child: Text(
                  'Sign In'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: _buttonStyle(),
              ),
            );
    });
  }
}

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    shadowColor: AppColors.mainColor,
    backgroundColor: AppColors.mainColor,
    shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15)),
  );
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class FormWidget extends StatefulWidget {
  FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _loginFormController = TextEditingController(text: 'string');
  final _passwordFormController = TextEditingController(text: 'string');

  @override
  void dispose() {
    _loginFormController.dispose();
    _passwordFormController.dispose();

    super.dispose();
  }

  final _formKeySub = GlobalKey<FormState>();
  bool _isToggle = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80, top: 50),
              child: Column(children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 35,
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Sign in to continue',
                  style:
                      TextStyle(fontSize: 20, color: AppColors.helpTextColor),
                ),
              ]),
            ),
            Form(
              key: _formKeySub,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Login',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // SizedBox(height: 10),
                  // TextFormField(
                  //   style: TextStyle(fontSize: 20),
                  //   cursorColor: AppColors.mainColor,
                  //   controller: _loginFormController,
                  //   decoration: InputDecoration(
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           width: 1, color: AppColors.helpTextColor),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           width: 1,
                  //           color: AppColors.mainColor.withOpacity(0.7)),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  // ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _loginFormController,
                        validator: ((value) =>
                            value!.isEmpty ? 'Please, enter login' : null),
                        style: TextStyle(fontSize: 20),
                        decoration: textFieldDecoration(),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: _isToggle ? true : false,
                        controller: _passwordFormController,
                        validator: ((value) =>
                            value!.isEmpty ? 'Please, enter paswword' : null),
                        style: TextStyle(fontSize: 20),
                        cursorColor: AppColors.mainColor,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: _toggle,
                              child: _isToggle
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: AppColors.helpTextColor,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: AppColors.mainColor,
                                    )),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.helpTextColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: AppColors.mainColor.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKeySub.currentState!.validate()) {
                              _formKeySub.currentState?.save();

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SendForm2(
                              //         name: _loginFormController.text,
                              //         signInModel: SignInModel(
                              //             login: _loginFormController.text,
                              //             password:
                              //                 _passwordFormController.text),
                              //       ),
                              //     ));
                              BlocProvider.of<SignBloc>(context, listen: false)
                                  .add(UserSignInEvent(
                                signInModel: SignInModel(
                                    login: _loginFormController.text,
                                    password: _passwordFormController.text),
                              ));
                            }
                          },
                          child: Text(
                            'Sign In'.toUpperCase(),
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shadowColor: AppColors.mainColor,
                            backgroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Need an account?',
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            child: Text(
                              'Sign up'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.mainColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _toggle() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }
}

InputDecoration textFieldDecoration() {
  return InputDecoration(
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.helpTextColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 1, color: AppColors.mainColor.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

// Widget formWithTittle(
//         String tittle, double size, TextEditingController controller) =>
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: size),
//         Text(tittle, style: TextStyle(fontSize: 18)),
//         SizedBox(height: size),
//         TextFormField(
//           controller: controller,
//           style: TextStyle(fontSize: 20),
//           decoration: textFieldDecoration(),
//         ),
//       ],
//     );

Text tittleForm(String text) {
  return Text(text, style: TextStyle(fontSize: 18));
}

Widget passwordFormWithTittle(String tittle, double size,
    TextEditingController controller, VoidCallback action, bool isToggle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: size),
      Text(
        tittle,
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 10),
      TextFormField(
        obscureText: isToggle,
        controller: controller,
        style: TextStyle(fontSize: 20),
        cursorColor: AppColors.mainColor,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: action,
              child: isToggle
                  ? Icon(
                      Icons.visibility_off,
                      color: AppColors.helpTextColor,
                    )
                  : Icon(
                      Icons.visibility,
                      color: AppColors.mainColor,
                    )),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.helpTextColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: AppColors.mainColor.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ],
  );
}