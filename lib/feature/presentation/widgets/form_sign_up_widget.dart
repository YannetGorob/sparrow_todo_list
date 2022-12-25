import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_up_model.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_state.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/group_home_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/form_sign_in_widget.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  List<GlobalKey<FormState>> _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  // final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final namefocusNode = FocusNode();
  final _surnamefocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    _surnameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    namefocusNode.dispose();
    _surnamefocusNode.dispose();

    super.dispose();
  }

  int currentStep = 0;
  bool _isToggle = true;
  bool _isToggleconf = true;

  @override
  Widget build(BuildContext context) {
    final String enteredLogin = _loginController.text;
    return Form(
      //autovalidateMode: AutovalidateMode.always,
      key: _formKey[currentStep],
      child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            _formKey[currentStep].currentState!.validate();
            if (isLastStep) {
              print('Completed');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendSignUpForm(
                          signUpModel: SignUpModel(
                            name: nameController.text,
                            surname: _surnameController.text,
                            email: _emailController.text,
                            login: _loginController.text,
                            phone: '+380${_phoneController.text}',
                            password: _passwordController.text,
                          ),
                          name: enteredLogin,
                        ),
                    fullscreenDialog: true),
              );

              // _showDialog(_loginController.text);
              //send data to a server

            } else if (currentStepValidate(currentStep)) {
              print('Valid');
              setState(() => currentStep += 1);
            }
          },
          onStepTapped: (step) => setState(() {
                currentStep = step;
              }), // tapping a step
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        isLastStep ? 'Confirm' : 'Next',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 20,
                          color: AppColors.mainBacgroundColor,
                        ),
                      ),
                      onPressed: details.onStepContinue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (currentStep != 0)
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'Back',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            color: AppColors.mainBacgroundColor,
                          ),
                        ),
                        onPressed: details.onStepCancel,
                      ),
                    ),
                  ),
              ]),
            );
          }),
    );
  }

  bool currentStepValidate(int step) {
    if (step == 0) {
      return nameController.text.isNotEmpty &&
          _surnameController.text.isNotEmpty;
    } else if (step == 1) {
      return ValidateEmail.validateEmail(_emailController.text) &&
          _loginController.text.isNotEmpty &&
          _validatePhoneNumber(_phoneController.text) &&
          _validatePasswordBool(
              _passwordController.text, _confirmPasswordController.text);
    } else {
      return false;
    }
  }

  String? _validatepassword(String? value) {
    if (_passwordController.text.length < 8) {
      return 'password must contain at leat 8 symbols';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  bool _validatePasswordBool(String value, String confirmValue) {
    if (value.isEmpty || value.length < 8) {
      return false;
    } else if (confirmValue != value) {
      return false;
    } else {
      return true;
    }
  }

  bool _validatePhoneNumber(String input) {
    if (input.isEmpty || input.length != 9) {
      return false;
    }
    return true;
  }

  void _toggle() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  void _toggleConfirm() {
    setState(() {
      _isToggleconf = !_isToggleconf;
    });
  }

  List<Step> getSteps() => [
        Step(
          state: currentStepValidate(0)
              ? StepState.complete
              : StepState.indexed, // making done icon or index icon
          isActive: currentStep >= 0,
          title: Text(
            'Account',
            style: TextStyle(fontSize: 18),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi!',
                style: TextStyle(
                    fontSize: 35,
                    color: AppColors.mainTextColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Create a new account',
                style: TextStyle(fontSize: 20, color: AppColors.helpTextColor),
              ),
              SizedBox(height: 20),
              tittleForm('Name'),
              SizedBox(height: 10),
              TextFormField(
                // onChanged: (value) {
                //   // _formKey[currentStep].currentState!.validate();
                //   if (value.isNotEmpty) {
                //       TextFieldDecoration.enabledBorder;
                //   }
                // },
                focusNode: namefocusNode,
                controller: nameController,
                autofocus: true,
                validator: ((value) =>
                    value!.isEmpty ? 'Required field' : null),
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    focusedErrorBorder: TextFieldDecoration.focusedErrorBorder,
                    enabledBorder: TextFieldDecoration.enabledBorder,
                    focusedBorder: TextFieldDecoration.focusedBorder,
                    errorBorder: TextFieldDecoration.errorBorder),
              ),
              SizedBox(height: 10),
              tittleForm('Surname'),
              SizedBox(height: 10),
              TextFormField(
                controller: _surnameController,
                focusNode: _surnamefocusNode,
                validator: ((value) =>
                    value!.isEmpty ? 'Required field' : null),
                style: TextStyle(fontSize: 20),
                decoration: textFieldDecoration(),
              ),
            ],
          ),
        ),
        Step(
          state:
              currentStepValidate(1) ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            'Contact',
            style: TextStyle(fontSize: 18),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tittleForm('Username'),
              SizedBox(height: 10),
              TextFormField(
                controller: _loginController,
                validator: ((value) =>
                    value!.isEmpty ? 'Required field' : null),
                style: TextStyle(fontSize: 20),
                decoration: textFieldDecoration(),
              ),
              SizedBox(height: 10),
              tittleForm('Email'),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: ((value) => value!.isEmpty
                    ? 'Required field'
                    : ValidateEmail.validateEmail(value)
                        ? null
                        : 'Please, enter an existing email'),
                style: TextStyle(fontSize: 20),
                decoration: textFieldDecoration(),
              ),
              SizedBox(height: 10),
              tittleForm('Phone'),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                validator: ((value) => value!.isEmpty
                    ? 'Required field'
                    : _validatePhoneNumber(value)
                        ? null
                        : 'Please, enter an existing number'),
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                      allow: true)
                ],
                decoration: InputDecoration(
                  prefixText: '+380 ',
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.helpTextColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: AppColors.mainColor.withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              tittleForm('Password'),
              SizedBox(height: 10),
              TextFormField(
                obscureText: _isToggle,
                controller: _passwordController,
                validator: _validatepassword,
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
                    borderSide:
                        BorderSide(width: 1, color: AppColors.helpTextColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: AppColors.mainColor.withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              tittleForm('Confirm Password'),
              SizedBox(height: 10),
              TextFormField(
                obscureText: _isToggleconf,
                controller: _confirmPasswordController,
                validator: _validatepassword,
                style: TextStyle(fontSize: 20),
                cursorColor: AppColors.mainColor,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: _toggleConfirm,
                      child: _isToggleconf
                          ? Icon(
                              Icons.visibility_off,
                              color: AppColors.helpTextColor,
                            )
                          : Icon(
                              Icons.visibility,
                              color: AppColors.mainColor,
                            )),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.helpTextColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: AppColors.mainColor.withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              // passwordFormWithTittle(
              //   'Password',
              //   10,
              //   _passwordController,
              //   _toggle,
              //   _isToggle,
              // ),
              // passwordFormWithTittle(
              //   'Conrfirm Password',
              //   10,
              //   _confirmPasswordController,
              //   _toggleConfirm,
              //   _isToggleconf,
              // ),
              // formWithTittle('Confirm Password', 10, _confirmPasswordController),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text(
            'Complete',
            style: TextStyle(fontSize: 18),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              confirmSignUp('First Name', nameController.text),
              SizedBox(height: 10),
              confirmSignUp('Last Name', _surnameController.text),
              SizedBox(height: 10),
              confirmSignUp('UserName', _loginController.text),
              SizedBox(height: 10),
              confirmSignUp('Phone', '+380${_phoneController.text}'),
              SizedBox(height: 10),
              confirmSignUp('Email', _emailController.text),
            ],
          ),
        ),
      ];

  Row confirmSignUp(String tittle, String formtittle) {
    return Row(
      children: [
        Expanded(
          child: Text(
            tittle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            formtittle,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }

  void _showDialog(String name) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Successful registration!'.toUpperCase(),
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
              ),
            ),
            content: Text(
              ' Welcome, $name! \n Nice to meet you! \n Your registration is successfully \n completed',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupHomeScreen(
                                name: name,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          );
        }));
  }
}

class SendSignUpForm extends StatelessWidget {
  const SendSignUpForm({
    super.key,
    required this.signUpModel,
    required this.name,
  });
  final SignUpModel signUpModel;
  final String name;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SignBloc>(context, listen: false)
        .add(UserSignUpEvent(signUpModel: signUpModel));
    return BlocBuilder<SignBloc, UserSignState>(
      builder: ((context, state) {
        if (state is UserLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoadedState) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: AlertDialog(
              title: Center(
                child: Text(
                  'Successful registration!'.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 17),
                ),
              ),
              content: Text(
                ' Welcome, $name! \n Nice to meet you! \n Your registration is successfully \n completed',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupHomeScreen(
                                  name: name,
                                ),
                            fullscreenDialog: true),
                      );
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            ),
          );
        } else if (state is UserErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                'Bad result',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
