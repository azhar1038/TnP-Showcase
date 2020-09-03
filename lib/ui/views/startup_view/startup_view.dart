import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/startup_view/startup_animation.dart';
import 'package:tnp/ui/views/startup_view/startup_viewmodel.dart';
import 'package:tnp/ui/widgets/loader.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (model) => model.startupLogic(),
        builder: (context, model, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(child: StartupAnimation()),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Loader(
                    text: 'Logging In...',
                  ),
                ),
              ],
            ),
          );
        });
  }
}
