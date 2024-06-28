import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../utils/utils.dart';
import 'widgets.dart';

 const bodyStyle = TextStyle(fontSize: 19.0);

const pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
  bodyTextStyle: TextStyle(
    fontSize: 18.0,
    color: Colors.black38
  ),
  bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
);

List<PageViewModel> pageViewModelList(GlobalKey<IntroductionScreenState> introKey) {
  return [
    PageViewModel(
      title: 'Fractional shares',
      body: 'Instead of having to buy an entire share, invest any amount you want.',
      image: buildSVG(AssetString.creditCardPayment),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: 'Learn as you go',
      body: 'Download the Stockpile app and master the market with our mini-lesson.',
      image: buildSVG(AssetString.mobilePay),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: 'Kids and teens',
      body:'Kids and teens can track their stocks 24/7 and place trades that you approve.',
      image: buildSVG(AssetString.onlineTransactions),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: 'Full Screen Page',
      body: 'Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.',
      image: buildFullscreenImage(AssetString.profileBG),
      decoration: pageDecoration.copyWith(
        contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        fullScreen: true,
        bodyFlex: 2,
        imageFlex: 3,
        safeArea: 100,
      ),
    ),
    PageViewModel(
      title: 'Another title page',
      body: 'Another beautiful body text for this example onboarding',
      image: buildSVG(AssetString.onlinePayments),
      decoration: pageDecoration.copyWith(
        bodyFlex: 6,
        imageFlex: 6,
        safeArea: 80,
      ),
    ),
    PageViewModel(
      title: 'Title of last page - reversed',
      bodyWidget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Click on ', style: bodyStyle),
          Icon(Icons.edit),
          Text(' to edit a post', style: bodyStyle),
        ],
      ),
      decoration: pageDecoration.copyWith(
        bodyFlex: 2,
        imageFlex: 4,
        bodyAlignment: Alignment.bottomCenter,
        imageAlignment: Alignment.topCenter,
      ),
      image: buildSVG(AssetString.onlineBanking),
      reverse: true,
    )
  ];
}