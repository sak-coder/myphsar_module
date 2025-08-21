import 'package:flutter/material.dart';

import 'myphsar_text_view.dart';

Widget notFound(BuildContext context, String text,
    {String image = "assets/images/notfound_ic.png", double width = 130}) =>   Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Image.asset(
              image,
              width: width,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          textView15(context: context, text: text, maxLine: 4, textAlign: TextAlign.center)
        ],
      ),

  );
