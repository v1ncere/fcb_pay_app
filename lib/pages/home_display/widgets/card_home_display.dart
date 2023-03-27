import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class CardHomeDisplay extends StatefulWidget {
  const CardHomeDisplay({super.key});

  @override
  State<CardHomeDisplay> createState() => _CardHomeDisplayState();
}

class _CardHomeDisplayState extends State<CardHomeDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color:const Color.fromARGB(122, 158, 255, 114),
        child: SizedBox(
          height: 200.0,
          child: BlocBuilder<HomeDisplayBloc, HomeDisplayState>(
            builder: (context, state) {
              // state is loading ==================================================
              if (state is HomeDisplayLoading) {
                return const Center(child: ShimmerLoader());
              }
              // state is loaded ===================================================
              if (state is HomeDisplayLoad) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Html(
                      data: state.homeDisplay.displayData,
                      tagsList: Html.tags..addAll(["bird", "flutter"]),
                      style: style(),
                      customRender: customRender(),
                      customImageRenders: {
                        networkSourceMatcher(domains: ["flutter.dev"]): (context, attributes, element) {
                          return const FlutterLogo(size: 36);
                        },
                        networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
                          headers: {"Custom-Header": "some-value"},
                          altWidget: (alt) => Text(alt ?? ""),
                          loadingWidget: () => const Text("Loading..."),
                        ),
                        // On relative paths starting with /wiki, prefix with a base url
                        (attr, _) => attr["src"] != null && attr["src"]!.startsWith("/wiki"): networkImageRender(
                          mapUrl: (url) => "https://upload.wikimedia.org${url!}"),
                        // Custom placeholder image for broken links
                        networkSourceMatcher(): networkImageRender(altWidget: (_) => const FlutterLogo()),
                      },
                      onLinkTap: (url, _, __, ___) {},
                      onImageTap: (src, _, __, ___) {},
                      onImageError: (exception, stackTrace) {},
                      onCssParseError: (css, messages) => null,
                    ),
                  ),
                );
              }
              // ===================================================================
              if (state is HomeDisplayError) {
                return Center(child: Text(state.error));
              }
              // ===================================================================
              else {
                return const Center(child: Text("Loading..."));
              }
            },
          ),
        ),
      ),
    );
  }
}