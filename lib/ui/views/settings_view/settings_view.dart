import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/app/enums.dart';
import 'package:tnp/ui/views/settings_view/settings_viewmodel.dart';
import 'package:tnp/ui/widgets/centered.dart';
import 'package:tnp/ui/widgets/fade_in.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle about = TextStyle(
      color: Color(0xff898989),
      fontSize: 12,
      fontFamily: 'Poppins',
    );
    return Centered(
      maxWidth: 700,
      child: ViewModelBuilder<SettingsViewModel>.nonReactive(
        builder: (context, model, child) {
          return SafeArea(
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: FadeIn(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16),
                      child: Text(
                        'Choose Theme: ',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    RadioListTile(
                      groupValue: model.theme,
                      value: ThemeType.Light,
                      title: Text(
                        'Light',
                        style: Theme.of(context).textTheme.subtitle1
                      ),
                      onChanged: (theme) => model.changeTheme(theme),
                    ),
                    RadioListTile(
                      groupValue: model.theme,
                      value: ThemeType.Dark,
                      title: Text(
                        'Dark',
                        style: Theme.of(context).textTheme.subtitle1
                      ),
                      onChanged: (theme) => model.changeTheme(theme),
                      activeColor: Colors.white,
                    ),
                    RadioListTile(
                      groupValue: model.theme,
                      value: ThemeType.Black,
                      title: Text(
                        'AMOLED Dark',
                        style: Theme.of(context).textTheme.subtitle1
                      ),
                      onChanged: (theme) => model.changeTheme(theme),
                      activeColor: Colors.white,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Logout',
                          ),
                        ),
                        onPressed: model.logout,
                      ),
                    ),
                    SizedBox(
                      height: 104,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Design and Developed by:', style: about),
                        SizedBox(height: 4),
                        Text('Md Azharuddin', style: about),
                        SizedBox(height: 12),
                        Text('Version:   ${model.appVersion}', style: about),
                        SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.copyright,
                              size: 12,
                              color: Color(0xff898989),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'IGIT 2020 - All rights reserved',
                              style: about,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => SettingsViewModel(),
      ),
    );
  }
}
