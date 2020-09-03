import 'package:injectable/injectable.dart';
import 'package:tnp/exceptions/url_launch_exception.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class UrlLaunchService{
  Future<bool> launchUrl(String url) async {
    if(await canLaunch(url)) return await launch(url);
    else throw UrlLaunchException("Failed to launch $url");
  }

  Future<bool> launchMail(String email, String subject, String body) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body
      }
    );
    String uri = _emailLaunchUri.toString();
    if(await canLaunch(uri)) return await launch(uri);
    else throw UrlLaunchException("Failed to send mail to $email");
  }
}