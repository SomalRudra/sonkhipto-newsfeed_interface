import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sonkhipto_news_interface/models/news.dart';
import 'package:sonkhipto_news_interface/utils/size_config.dart';
import 'package:sonkhipto_news_interface/utils/style.dart';

import 'news_ui.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;
  int newsImageHeight = 0;
  int newsImageWidth = 0;
  List<News> newsList = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    newsImageHeight = (SizeConfig.getScreenSize(context).height * 0.8).round();
    newsImageWidth = (SizeConfig.getScreenSize(context).width * 0.8).round();
    newsList.add(News(
        "Shah Rukh Khan Is An Indian Actor, Film Producer, And Tv Personality",
        "Shah Rukh Khan Is An Indian Actor, Film Producer, And Tv Personality. He Has Appeared In More Than 80 Films And Earned Numerous Accolades. He Has A Significant Following In Asia And The Indian Diaspora Worldwide",
        "https://picsum.photos/$newsImageHeight/$newsImageWidth"));
    newsList.add(News(
        "The dog has been found",
        "Shah Rukh Khan Is An Indian Actor, Film Producer, And Tv Personality. He Has Appeared In More Than 80 Films And Earned Numerous Accolades. He Has A Significant Following In Asia And The Indian Diaspora Worldwide",
        "https://picsum.photos/$newsImageHeight/$newsImageWidth"));

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.colorBluegrey,
        body: Column(
          children: [
            Center(
              child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 30),
                  height: SizeConfig.getScreenSize(context).height * 0.7,
                  width: SizeConfig.getScreenSize(context).width * 0.95,
                  // margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: newsList.length,
                    itemBuilder: (context, index) => NewsUI(
                      news: newsList[index],
                      controller: pageController,
                    ),
                    onPageChanged: (index) => setState(() => pageIndex = index),
                  )),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 1,
              child: SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotWidth: SizeConfig.blockSizeHorizontal * 2,
                      dotHeight: SizeConfig.blockSizeHorizontal * 2,
                      activeDotColor: Colors.white), // your preferred effect
                  onDotClicked: (index) {}),
            )
          ],
        ),
      ),
    );
  }
}
