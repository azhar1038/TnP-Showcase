import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/app/router.gr.dart';
import 'package:tnp/datamodels/news.dart';
import 'package:tnp/managers/news_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tnp/services/url_launch_service.dart';

class NewsViewModel extends FutureViewModel<List<News>> {
  NewsManager _newsManager = locator<NewsManager>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  UrlLaunchService _urlLaunch = locator<UrlLaunchService>();

  @override
  void onError(error) {
    _dialogService.showCustomDialog(
      customData: DialogType.Alert,
      title: 'Error',
      description: 'Failed to fetch News. Try again later.',
    );
    super.onError(error);
  }

  void navigateToWebview(String title, String url) {
    if(kIsWeb){
      _urlLaunch.launchUrl(url);
    }else
    _navigationService.navigateTo(Routes.webview,
        arguments: InAppWebViewArguments(
          title: title,
          link: url,
        ));
  }

  @override
  Future<List<News>> futureToRun() => _newsManager.getNews();
}
