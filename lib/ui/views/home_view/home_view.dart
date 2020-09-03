import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:tnp/datamodels/navbar_item.dart';
import 'package:tnp/ui/views/home_view/home_viewmodel.dart';
import 'package:tnp/ui/widgets/navbar_bottom.dart';
import 'package:tnp/ui/widgets/navbar_side.dart';
import 'package:tnp/ui/widgets/top_bar.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  List<NavbarItem> _items;
  HomeViewModel _model;

  @override
  void initState() {
    _items = [
      NavbarItem(
        title: 'Notification',
        icon: Icons.notifications,
      ),
      NavbarItem(
        title: 'News',
        icon: Icons.view_list,
      ),
      NavbarItem(
        title: 'Profile',
        icon: Icons.person,
      ),
      NavbarItem(
        title: 'Settings',
        icon: Icons.settings,
      ),
    ];
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _model != null) {
      _model.reloadTheme();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            var deviceType = getDeviceType(MediaQuery.of(context).size);
            return Scaffold(
              appBar: deviceType == DeviceScreenType.desktop
                  ? null
                  : TopBar(
                      title: model.getTitle(model.currentIndex),
                    ),
              floatingActionButton: model.currentIndex==2?FloatingActionButton.extended(
                onPressed: model.navigateToEdit,
                label: Text('Edit'),
                icon: Icon(Icons.edit),
                backgroundColor: Theme.of(context).buttonColor,
              ):null,
              bottomNavigationBar: orientation == Orientation.portrait
                  ? NavbarBottom(
                      items: _items,
                      activeColor: Theme.of(context).buttonColor,
                      onChange: model.setIndex,
                      initialIndex: model.currentIndex,
                    )
                  : null,
              body: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  orientation == Orientation.landscape
                      ? NavbarSide(
                          items: _items,
                          activeColor: Theme.of(context).buttonColor,
                          onChange: model.setIndex,
                          initialIndex: model.currentIndex,
                        )
                      : SizedBox(height: 0, width: 0),
                  Expanded(
                    child: model.getPage(model.currentIndex),
                  ),
                ],
              ),
            );
          },
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
