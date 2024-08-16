import 'package:flutter/material.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/directory.dart';
import 'package:weatther_app/constant/pref_key.dart';
import 'package:weatther_app/repo/sharedprefrences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SharedPrefrencesService().getBoolData(PrefKey.isLogin).then((value) {
        if (value == true) {
          Navigator.pushNamed(context, "/home");
        }
      });
    });
  }

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
                        SharedPrefrencesService()
                            .saveBoolData(PrefKey.isLogin, true)
                            .then((value) {
                          Navigator.pushNamed(context, "/home");
                        });
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                ),
                const SizedBox(
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
