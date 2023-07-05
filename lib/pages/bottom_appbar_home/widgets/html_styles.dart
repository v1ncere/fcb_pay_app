import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Map<String, Style> style() => {
  "table": Style(
    backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
  ),
  "th": Style(
    padding: HtmlPaddings.all(6),
    backgroundColor: Colors.grey,
  ),
  "td": Style(
    padding: HtmlPaddings.all(6),
    border: const Border(bottom: BorderSide(color: Colors.grey)),
  ),
  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
  'flutter': Style(
    display: Display.block,
    fontSize: FontSize(5, Unit.em),
  ),
  ".second-table": Style(
    backgroundColor: Colors.transparent,
  ),
  ".second-table tr td:first-child": Style(
    fontWeight: FontWeight.bold,
    textAlign: TextAlign.end,
  ),
};

List<HtmlExtension> customExtentions() => [
  TagWrapExtension(
    tagsToWrap: {"table"},
    builder: (child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      );
    }
  ),
  TagExtension.inline(
    tagsToExtend: {"bird"},
    child: const TextSpan(text: "🐦"),
  ),
  TagExtension(
    tagsToExtend: {"flutter"},
    builder: (context) => CssBoxWidget(
      style: context.styledElement!.style,
      child: FlutterLogo(
        style: context.attributes['horizontal'] != null
          ? FlutterLogoStyle.horizontal
          : FlutterLogoStyle.markOnly,
        textColor: context.styledElement!.style.color!,
        size: context.styledElement!.style.fontSize!.value,
      ),
    ),
  ),
  ImageExtension(
    handleAssetImages: false,
    handleDataImages: false,
    networkDomains: {"flutter.dev"},
    child: const FlutterLogo(size: 36),
  ),
  ImageExtension(
    handleAssetImages: false,
    handleDataImages: false,
    networkDomains: {"mydomain.com"},
    networkHeaders: {"Custom-Header": "some-value"},
  ),
];