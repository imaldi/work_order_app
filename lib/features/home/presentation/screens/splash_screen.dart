import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/core/router/router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1, milliseconds: 500), // Durasi 1.5 detik
    )..forward().then((a){
      context.replaceRoute(MainRoute());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value *
                      2 *
                      3.14159265359, // 360 derajat
                  child: child,
                );
              },
              child: Container(
                height: 400,
                child:
                Icon(Icons.cases_rounded, size: 64, color: Colors.blueAccent,)
                // Image.asset('assets/icons/maintainx_icon.png'),
              ),
            ),
            //   MyGradientContainer(
            //     height: 300,
            //     width: 300,
            //     child: Center(
            //         child: Text(
            //       "Splash Screen",
            //       style: TextStyle(fontSize: 32.0),
            //     )),
            //   ),
          ),
    );
  }
}
