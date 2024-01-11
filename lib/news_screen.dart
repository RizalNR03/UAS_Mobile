import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uts/signin_helper.dart';

import 'api.dart';
import 'components/card_news.dart';
import 'components/mytext.dart';
import 'models/model_news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String? userID;
  List<Article> newsList = [];

  void getUserData() async {
    await GoogleSignInHelper().getUserData().then((value) {
      if (value != null) {
        setState(() {
          userID = value.uid;
        });
      }
    });
    getNews();
  }

  void getNews() async {
    List<Article> list = await API().getNewsHeadlines();
    await Future.delayed(Duration(milliseconds: 100));

    setState(() {
      newsList = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return newsList.isNotEmpty
        ? ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(2.h),
            itemCount: newsList.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) => CardNews(
              data: newsList[index],
              onClick: () async {},
            ),
          )
        : Center(
            child: OutlinedButton(
                onPressed: () {
                  getNews();
                },
                child: MyText('Refresh')),
          );
  }
}
