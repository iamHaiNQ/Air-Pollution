import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;

  Widget _buildUserTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        TextField(
          keyboardType: TextInputType.name,
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
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            hintText: 'Nhập tên của bạn',
            hintStyle: TextStyle(
              color: Colors.black54,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
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
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.grey,
            ),
            hintText: 'Nhập Email của bạn',
            hintStyle: TextStyle(
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
        SizedBox(height: 10.0),
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
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
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
            hintStyle: TextStyle(
              color: Colors.black54,
              fontFamily: 'OpenSans',
            ),
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
          onPressed: () => print('Nút đăng kí Được Nhấn'),
          child: const Text(
            'Signup',
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

  Widget _buildLoginBtn() {
    return Center(
      child: GestureDetector(
        onTap: () => print('Login Button Pressed'),
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
                    MaterialPageRoute(builder: (context) => MainPage()),
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
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                        SizedBox(height: 30.0),
                        _buildUserTF(),
                        SizedBox(height: 30),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
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
