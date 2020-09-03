import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/ui/views/force_update_view/force_update_viewmodel.dart';

class ForceUpdateView extends StatefulWidget {
  @override
  _ForceUpdateViewState createState() => _ForceUpdateViewState();
}

class _ForceUpdateViewState extends State<ForceUpdateView>
    with WidgetsBindingObserver {
  ForceUpdateViewModel _model;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _model != null)
      _model.reloadTheme();
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForceUpdateViewModel>.nonReactive(
      viewModelBuilder: () => ForceUpdateViewModel(),
      onModelReady: (model) => _model = model,
      builder: (context, model, build) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Important',
                    style: Theme.of(context)
                        .textTheme
                        .headline5,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'An Update is Available!\n\nTo continue using the app without' +
                          ' any problems and access all latest features, please update to the latest version.',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Open Playstore'),
                      onPressed: model.openPlayStore,
                    ),
                    RaisedButton(
                      child: Text('  Update Now  '),
                      onPressed: model.forceUpdate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
