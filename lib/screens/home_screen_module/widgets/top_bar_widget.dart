import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weatther_app/constant/colors.dart';
import 'package:weatther_app/constant/directory.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
  });

  String _getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('E, d MMM').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _getGreeting(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              _getCurrentDate(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/settings");
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Clr.greyAEAEAE, width: 0.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageIcon(
                const AssetImage(
                  Dir.humbergerIcon,
                ),
                color: Clr.greyAEAEAE,
                size: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
