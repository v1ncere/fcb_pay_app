import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:fcb_pay_app/pages/home_webview/bloc/home_webview_bloc.dart';
import 'package:fcb_pay_app/pages/home_webview/widgets/shimmer_loader.dart';
import 'package:fcb_pay_app/pages/home_webview/widgets/widgets.dart';

class HomeWebviewView extends StatefulWidget {
  const HomeWebviewView({super.key});
  
  @override
  State<HomeWebviewView> createState() => _HomeWebviewViewState();
}

class _HomeWebviewViewState extends State<HomeWebviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App Dynamic",
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: BlocBuilder<HomeWebviewBloc, HomeWebviewState>(
        builder: (context, state) {
          if(state is HomeWebviewLoading) {
            return const Center(child: ShimmerLoader());
          }
          if (state is HomeWebviewLoaded) {
            return SingleChildScrollView(
              child: Html(
                data: state.displayModel.html,
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
                  networkSourceMatcher() : networkImageRender(
                    altWidget: (_) => const FlutterLogo()
                  ),
                },
                onLinkTap: (url, _, __, ___) {},
                onImageTap: (src, _, __, ___) {},
                onImageError: (exception, stackTrace) {},
                onCssParseError: (css, messages) {
                  return null;
                },
              ),
            );
          }
          if (state is HomeWebviewLoadFailure) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      )
    );
  }
}