import 'package:flutter/material.dart' hide Notification;
import 'package:stacked/stacked.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/news.dart';
import 'package:tnp/ui/views/news_view/news_viewmodel.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/fade_in.dart';
import 'package:tnp/ui/widgets/loader.dart';

class NewsView extends StatelessWidget {
  Widget displayNews(
      News news, BuildContext context, Function(String, String) launch) {
    return Centered(
      maxWidth: maxWidth,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 0.7,
                        ),
                      ),
                    ),
                    child: Text(
                      news.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  child: Text(
                    news.date,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ),
            Divider(thickness: 0.7),
            Text(
              news.body,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            news.link != null
                ? OutlineButton(
                    child: Text('Know More'),
                    textColor: Theme.of(context).buttonColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonColor,
                      width: 2,
                    ),
                    onPressed: () => launch(news.title, news.link),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
      builder: (context, model, child) {
        if (model.isBusy)
          return Center(child: Loader(text: 'Loading...'));
        else if (model.hasError)
          return Container(
            alignment: Alignment.center,
            child: Text(
              'Failed to fetch News',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          );
        int newsLength = model.data.length;
        return FadeIn(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 12),
            physics: BouncingScrollPhysics(),
            itemCount: newsLength,
            itemBuilder: (context, index) {
              return displayNews(
                model.data[index],
                context,
                model.navigateToWebview,
              );
            },
          ),
        );
      },
      viewModelBuilder: () => NewsViewModel(),
    );
  }
}
