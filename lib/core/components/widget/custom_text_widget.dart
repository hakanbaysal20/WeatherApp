

import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/color_constants.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;

  CustomTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(color: ColorConstants.white),);
  }
}