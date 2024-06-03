import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/ui/components/text_field_widget.dart';
import 'package:airpollution/ui/pages/login/login_page.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:airpollution/ui/pages/signup/signup_cubit.dart';
import 'package:airpollution/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpCubit();
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({Key? key}) : super(key: key);

  @override
  State<SignUpChildPage> createState() => _SignUpChildPageState();
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  late final SignUpCubit _cubit;
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Widget _buildUserTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        TextFieldWidget(
          controller: userController,
          labelText: "Họ và tên",
          maxLines: 5,
          prefix: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        TextFieldWidget(
          controller: emailController,
          labelText: "Email",
          maxLines: 5,
          prefix: const Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        TextFieldWidget(
          controller: passwordController,
          labelText: "Mật khẩu",
          maxLines: 5,
          prefix: const Icon(
            Icons.key,
            color: Colors.grey,
          ),
          suffix: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFF188EFF),
              Color(0xFF53FEEF),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            final result = await _cubit.onSignUp(
              email: emailController.text,
              password: passwordController.text,
              userName: userController.text,
            );

            if (result != null) {
              logger.d("signup success");
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(
            'Signup',
            style: AppTextStyle.blackS18Bold.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Have an Account? ',
                style: TextStyle(
                  color: Color(0xff646465),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Lognin',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Signup",
                          style: AppTextStyle.textLoginHeadline,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Please signup to get your local AQI data.",
                          style: AppTextStyle.textLoginBody,
                        ),
                        const SizedBox(height: 8),
                        _buildUserTF(),
                        const SizedBox(height: 8),
                        _buildEmailTF(),
                        const SizedBox(height: 8),
                        _buildPasswordTF(),
                        _buildSignupBtn(),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
