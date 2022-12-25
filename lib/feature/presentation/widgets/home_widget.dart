import 'package:flutter/material.dart';

import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/sign_in_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/sign_up_screen.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            color: AppColors.mainColor,
          ),
          SizedBox(height: 50),
          Text(
            'Hello !',
            style: TextStyle(
                fontSize: 35,
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "It's Best place  to organise your time",
            style: TextStyle(fontSize: 20, color: AppColors.helpTextColor),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SignInScreen())),
                  );
                },
                child: Text(
                  'Login'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: AppColors.mainBacgroundColor,
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
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SignUpScreen()),
                        fullscreenDialog: true),
                  );
                },
                child: Text(
                  'SignUp'.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: AppColors.mainColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  backgroundColor: AppColors.mainBacgroundColor,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: AppColors.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
