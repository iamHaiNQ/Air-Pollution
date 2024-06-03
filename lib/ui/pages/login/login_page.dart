import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/models/entities/account_entity.dart';
import 'package:airpollution/services/share_preferences_storage.dart';
import 'package:airpollution/ui/components/text_field_widget.dart';
import 'package:airpollution/ui/pages/login/login_cubit.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:airpollution/ui/pages/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({Key? key}) : super(key: key);

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;
  late TextEditingController userController;
  late TextEditingController passwordController;
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        TextFieldWidget(
          controller: userController,
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
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckboxAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
          child: Row(
            children: <Widget>[
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: true,
                  checkColor: Colors.white,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    // setState(() {
                    //   _rememberMe = value!;
                    // });
                  },
                ),
              ),
              const Text(
                'Remember me',
                style: TextStyle(
                  color: Color(0xff111827),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
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
            padding: const EdgeInsets.all(15.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            final result = await _cubit.onLogin(
              userName: userController.text,
              password: passwordController.text,
              isRemember: true,
            );

            if (result != null) {
              final user = AccountEntity();
              SharedPreferencesStorage.setUser(user);

              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Text(
            'Login',
            style: AppTextStyle.blackS18Bold.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ),
          );
        },
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Color(0xff646465),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
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
                    MaterialPageRoute(builder: (context) => const MainPage()),
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
                          "Login",
                          style: AppTextStyle.textLoginHeadline,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Please login to get your local AQI data.",
                          style: AppTextStyle.textLoginBody,
                        ),
                        const SizedBox(height: 30.0),
                        _buildEmailTF(),
                        const SizedBox(height: 8),
                        _buildPasswordTF(),
                        _buildRememberMeCheckboxAndForgotPassword(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
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
