import 'package:flutter/material.dart';
import 'package:mobile/models/app_state.dart';
import 'package:mobile/models/auth_service.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/pages/home_page.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/me_page.dart';
import 'package:mobile/pages/product_page.dart';
import 'package:provider/provider.dart';

class AppStructure extends StatefulWidget {
  @override
  _AppStructureState createState() => _AppStructureState();
}

class _AppStructureState extends State<AppStructure> {
  int _selectedIndex = 0;
  bool isWelcomePageShown = true;

  final itemNames = <_Item>[
    _Item('首页', Icons.home),
    _Item('产品', Icons.language),
    _Item('行程', Icons.trip_origin),
    _Item('我的', Icons.face),
  ];

  List<BottomNavigationBarItem> get _itemList {
    return itemNames
        .map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon, color: ColorConstants.NORMAL),
            title: Text(item.name),
            activeIcon: Icon(item.icon, color: ColorConstants.ACTIVE)))
        .toList();
  }

  List<Widget> _pages = <Widget>[
    HomePage(),
    ProductsPage(),
    Text('Journey'),
    MePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return Stack(
        children: <Widget>[
          Offstage(
            child: Scaffold(
              appBar: AppBar(
                title: Image.asset(Constants.STATIC_IMG + 'logo-icon.png',
                    width: 80),
//              title: Image.asset(
//                Constants.STATIC_IMG + 'logo.jpg',
//                width: 120,
//              ),
                centerTitle: true,
                elevation: 0,
              ),
              body: _pages.elementAt(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: _itemList,
                currentIndex: _selectedIndex,
                selectedItemColor: ColorConstants.ACTIVE,
                onTap: _onItemTapped,
                showUnselectedLabels: true,
                unselectedItemColor: ColorConstants.NORMAL,
              ),
              backgroundColor: ColorConstants.BACKGROUND_PRIMARY,
            ),
            offstage: isWelcomePageShown,
          ),
          Offstage(
            child: Container(
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() => isWelcomePageShown = false);
                    },
                  ),
                  Center(child: Text('Welcome to Triphub')),
                ],
              ),
            ),
            offstage: !isWelcomePageShown,
          )
        ],
      );
    });
  }
}

class _Item {
  String name;
  IconData icon;

  _Item(this.name, this.icon);
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}