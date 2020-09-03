import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/ui/views/inapp_web_view/inapp_web_viewmodel.dart';
import 'package:tnp/ui/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  final String title, link;

  const InAppWebView({Key key, @required this.title, @required this.link})
      : super(key: key);

  @override
  _InAppWebViewState createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView>
    with WidgetsBindingObserver {
  final _key = UniqueKey();
  InAppWebViewModel _model;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _model != null)
      _model.reloadTheme();
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InAppWebViewModel>.reactive(
      viewModelBuilder: () => InAppWebViewModel(),
      onModelReady: (model) {
        _model = model;
        model.checkAndLaunchDriveDownload(widget.link);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: IndexedStack(
                    index: model.viewIndex,
                    children: <Widget>[
                      WebView(
                        key: _key,
                        initialUrl: widget.link,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageFinished: model.onPageFinished,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Having trouble viewing this page?\n\nTry opening in browser\n(bottom-right icon)',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Loader(
                          text: 'Loading Page...',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                    border: model.theme != ThemeType.Light
                        ? Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1))
                        : null,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        tooltip: 'Back',
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      IconButton(
                        icon: Icon(Icons.open_in_browser),
                        color: Theme.of(context).textTheme.headline6.color,
                        tooltip: 'Open in Browser',
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => model.launchBrowser(widget.link),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
