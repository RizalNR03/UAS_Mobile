import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/model_news.dart';
import 'mytext.dart';

class CardNews extends StatelessWidget {
  const CardNews({super.key, required this.data, required this.onClick});
  final Article data;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
          child: InkWell(
            onTap: onClick,
            child: Row(
              children: [
                Container(
                  width: 12.h,
                  height: 12.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                      image: DecorationImage(
                          image: NetworkImage(data.urlToImage ??
                              'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      data.title,
                      weight: FontWeight.w600,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    MyText(
                      'By ${data.author}',
                      color: Colors.grey,
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
