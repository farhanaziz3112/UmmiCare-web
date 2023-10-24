import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class mainNavItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String path;
  const mainNavItem(this.path, this.isSelected, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              context.go(path);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 120, 219, 218),
              elevation: 0.0,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              context.go(path);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff71CBCA),
              elevation: 0.0,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
