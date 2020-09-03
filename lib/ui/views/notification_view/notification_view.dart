import 'package:flutter/material.dart' hide Notification;
import 'package:stacked/stacked.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/datamodels/notification.dart';
import 'package:tnp/ui/views/notification_view/notification_viewmodel.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/fade_in.dart';
import 'package:tnp/ui/widgets/loader.dart';

class NotificationView extends StatelessWidget {
  Widget displayNotification(Notification notification, BuildContext context) {
    var dateAndTime = notification.dateAndTime.split(', ');
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
                    notification.subject,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${dateAndTime[0]}\n${dateAndTime[1]}',
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            ),
            Divider(thickness: 0.7),
            Text(
              notification.content,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Centered(
      maxWidth: 700,
      child: ViewModelBuilder<NotificationViewModel>.reactive(
        builder: (context, model, child) {
          if (model.isBusy)
            return Center(child: Loader(text: 'Loading...'));
          else if (model.hasError)
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Failed to fetch Notifications',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            );
          int notificationLength = model.data.length;
          return FadeIn(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 12),
              physics: BouncingScrollPhysics(),
              itemCount: notificationLength,
              itemBuilder: (context, index) {
                return displayNotification(model.data[index], context);
              },
            ),
          );
        },
        viewModelBuilder: () => NotificationViewModel(),
      ),
    );
  }
}
