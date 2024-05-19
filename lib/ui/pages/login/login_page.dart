import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:airpollution/ui/pages/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscureText = true;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.only(top: 14.0),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.grey,
            ),
            hintText: 'Nhập Email của bạn',
            hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        TextField(
          obscureText: _obscureText,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.only(top: 14.0),
            prefixIcon: const Icon(
              Icons.key,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            hintText: 'Nhập Password của bạn',
            hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: 'OpenSans',
            ),
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
            onPressed: () => print('Forgot Password Button Pressed'),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro Display',
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
                  value: _rememberMe,
                  checkColor: Colors.white,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
              ),
              const Text(
                'Remember me',
                style: TextStyle(
                  color: Color(0xff111827),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SF Pro Display',
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
            padding: const EdgeInsets.all(15.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () => print('Nút Đăng Nhập Được Nhấn'),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
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
            MaterialPageRoute(builder: (context) => SignUpScreen()),
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
                        const SizedBox(height: 30.0),
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
