import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sonkhipto_news_interface/models/news.dart';
import 'package:sonkhipto_news_interface/utils/size_config.dart';
import 'package:sonkhipto_news_interface/utils/style.dart';

class NewsUI extends StatefulWidget {
  final News news;
  final PageController controller;

  const NewsUI({Key? key, required this.news, required this.controller})
      : super(key: key);

  @override
  _NewsUIState createState() => _NewsUIState();
}

class _NewsUIState extends State<NewsUI> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        margin: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            isExpanded
                ? Container()
                : Positioned(
                    top: SizeConfig.blockSizeHorizontal * 10,
                    child: SizedBox(
                      width: SizeConfig.bodyWidth * 0.5,
                      child: Text('Tap On The Image To Expand The News',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 0.5,
                              fontFamily: CustomFonts.treMS,
                              fontSize: SizeConfig.blockSizeHorizontal * 3)),
                    )),
            backgroundNewsBodyWidget(context),
            foregroundNewsTitleWidget(),
          ],
        ));
  }

  AnimatedPositioned backgroundNewsBodyWidget(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: isExpanded
          ? SizeConfig.bodyHeight * 0.05
          : SizeConfig.bodyHeight * 0.08,
      width:
          isExpanded ? SizeConfig.bodyWidth * 0.78 : SizeConfig.bodyWidth * 0.7,
      height: isExpanded
          ? SizeConfig.bodyHeight * 0.45
          : SizeConfig.bodyWidth * 0.5,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                spreadRadius: -20,
                blurRadius: 30,
                offset: const Offset(5, 30), // changes position of shadow
              ),
            ],
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        padding: const EdgeInsets.all(8),
        child: newsbody_body(),
      ),
    );
  }

  Column newsbody_body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 8,
              right: SizeConfig.blockSizeHorizontal * 8),
          child: Text(widget.news.newsBody!,
              maxLines: isExpanded ? 10 : 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle1(
                  Colors.grey, SizeConfig.blockSizeHorizontal * 3.5)),
        ),
        isExpanded
            ? SizedBox(
                height: isExpanded
                    ? SizeConfig.bodyHeight * 0.02
                    : SizeConfig.bodyHeight * 0.1)
            : Container()
      ],
    );
  }

  AnimatedPositioned foregroundNewsTitleWidget() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: isExpanded
          ? SizeConfig.bodyHeight * 0.02
          : SizeConfig.bodyHeight * 0.22,
      // bottom: isExpanded
      //     ? SizeConfig.bodyHeight * 0.25
      //     : SizeConfig.bodyHeight * 0.25,
      width:
          isExpanded ? SizeConfig.bodyWidth * 0.78 : SizeConfig.bodyWidth * 0.7,
      height: isExpanded
          ? SizeConfig.bodyHeight * 0.5
          : SizeConfig.bodyHeight * 0.8,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: SizedBox(
          child: Column(
            children: [
              Image.network(widget.news.imageUrl!),
              newstitle_body(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded newstitle_body() {
    return Expanded(
      child: Padding(
        padding: isExpanded
            ? EdgeInsets.all(SizeConfig.blockSizeHorizontal * 10)
            : EdgeInsets.only(
                top: SizeConfig.blockSizeHorizontal * 4,
                left: SizeConfig.blockSizeHorizontal * 4,
                right: SizeConfig.blockSizeHorizontal * 4,
                bottom: SizeConfig.blockSizeHorizontal * 1),
        child: Text(
          widget.news.newsTitle!,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextFontStyle.textStyle1(
              Colors.white, SizeConfig.blockSizeHorizontal * 4),
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
