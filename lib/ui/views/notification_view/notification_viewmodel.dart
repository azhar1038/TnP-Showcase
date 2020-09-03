import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/app/locator.dart';
import 'package:tnp/datamodels/notification.dart';
import 'package:tnp/datamodels/student.dart';
import 'package:tnp/managers/notification_manager.dart';
import 'package:tnp/managers/user_manager.dart';

class NotificationViewModel extends FutureViewModel<List<Notification>> {
  UserManager _userManager = locator<UserManager>();
  NotificationManager _notificationManager = locator<NotificationManager>();
  DialogService _dialogService = locator<DialogService>();

  @override
  void onError(error) {
    _dialogService.showCustomDialog(
      customData: DialogType.Alert,
      title: 'Error',
      description: 'Failed to fetch Notifications. Try again later.',
    );
    super.onError(error);
  }

  @override
  Future<List<Notification>> futureToRun() {
    Student student = _userManager.user.student;
    return _notificationManager.getNotifications(
      student.batch,
      student.branch,
      student.course,
      student.placed,
    );
  }
}
