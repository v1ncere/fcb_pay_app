import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.data });
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF02AE08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Html(
              data: data,
              tagsList: Html.tags..addAll(["bird", "flutter"]),
              style: style(),
              customRender: customRender(),
              customImageRenders: {
                networkSourceMatcher(domains: ["flutter.dev"]): (context, attributes, element) => const FlutterLogo(size: 36),
                networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
                  headers: {"Custom-Header": "some-value"},
                  altWidget: (alt) => Text(alt ?? ""),
                  loadingWidget: () => const Text("Loading..."),
                ),
                // On relative paths starting with /wiki, prefix with a base url
                (attributes, element) => attributes["src"] != null && attributes["src"]!.startsWith("/wiki")
                  : networkImageRender(mapUrl: (url) => "https://upload.wikimedia.org${url!}"),
                // Custom placeholder image for broken links
                networkSourceMatcher(): networkImageRender(altWidget: (alt) => const FlutterLogo()),
              },
              onLinkTap: (url, context, attributes, element) {},
              onImageTap: (src, context, attributes, element) {},
              onImageError: (exception, stackTrace) {},
              onCssParseError: (css, messages) => null,
            ),
          ),
        ),
      ),
    );
  }
}