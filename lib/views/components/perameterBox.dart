import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors_utils.dart';

Widget perameterBox(
    {required IconData icon, required String name, required String perameter}) {
  return Container(
    height: 190,
    width: 190,
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: MyColor.theme1,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: MyColor.white.withOpacity(0.6),
          size: 36,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: MyColor.white.withOpacity(0.6),
          ),
        ),
        Text(
          perameter,
          style: TextStyle(
            fontSize: 28,
            color: MyColor.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
