import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'forecast_widget.dart'; // Import ForecastWidget

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({Key? key}) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Background image from assets
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 363,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/white-cloud-sky-background 1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 363,
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Welcome👋',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                        letterSpacing: 0.5,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  Text(
                    'User',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 38 / 28,
                      letterSpacing: 0.4,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  liveLocation(),
                  ForecastWidget(), // Add ForecastWidget here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget liveLocation() {
    return Container(
      width: 360,
      constraints: BoxConstraints(minHeight: 108),
      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.gps_fixed,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
