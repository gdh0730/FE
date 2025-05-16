import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/commons/button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(showBackButton: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontFamily: 'PretendardBlack',
                    fontSize: 25,
                  ),
                ),
              ),
              // 구글 소셜로그인 버튼
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: CommonButton(
                    // 구글 로그인 버튼 클릭 시, 구글 로그인 기능 호출
                    // 우선 구글 로그인 기능은 구현하지 않고, 버튼 클릭 시 콘솔에 "Google Login" 출력
                    onPressed: () {
                      print("Google Login");
                    },
                    /*
                    onPressed: () async {
                      final userCredential = await signInWithGoogle();
                      if (userCredential != null {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
                    */
                    text: "Login with Google",
                    icon: Image.asset("assets/icons/glogo.png", width: 25),
                    type: ButtonType.elevated,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}