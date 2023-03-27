import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

Map<String, Style> style() => {
  "html": Style(
    backgroundColor: Colors.transparent,
  ),
  "table": Style(
    backgroundColor:const Color.fromARGB(0x50, 0xee, 0xee, 0xee)
  ),
  "tr": Style(
    border:const Border(
      bottom: BorderSide(color: Colors.white60)
    ),
  ),
  "th": Style(
    padding:const EdgeInsets.all(6),
    backgroundColor: Colors.grey,
  ),
  "td": Style(
    padding:const EdgeInsets.all(6),
    alignment: Alignment.topLeft,
  ),
  "h5": Style(maxLines: 2, textOverflow: TextOverflow.fade),
  "var": Style(fontFamily: 'serif'),
};

Map<String, dynamic Function(RenderContext, Widget)> customRender() => {
  "table": (context, child) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: (context.tree as TableLayoutElement).toWidget(context),
    );
  },
  "bird": (RenderContext context, Widget child) {
    return const TextSpan(text: "🐦");
  },
  "flutter": (RenderContext context, Widget child) {
    return FlutterLogo(
      style: (context.tree.element!.attributes['horizontal'] != null)
        ? FlutterLogoStyle.horizontal
        : FlutterLogoStyle.markOnly,
      textColor: context.style.color!,
      size: context.style.fontSize!.size! * 5,
    );
  },
};