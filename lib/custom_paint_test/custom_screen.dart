import 'package:flutter/material.dart';
import 'package:personal_money_management_app/custom_paint_test/custom_paint_widget.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              color: Colors.white,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
