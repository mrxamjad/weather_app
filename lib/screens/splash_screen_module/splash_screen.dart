import 'package:flutter/material.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/directory.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Dir.onboardingBg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Never get caught in the rain again",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Stay ahead of the weather with our accurate forecasts",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 102,
                ),
                SizedBox(
                  height: 56,
                  width: screenSize.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Clr.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 58,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
