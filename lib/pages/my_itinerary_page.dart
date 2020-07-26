import 'package:flutter/material.dart';
import 'package:mobile/Router.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/models/app_state.dart';
import 'package:mobile/models/auth_service.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/widgets/cards.dart';
import 'package:provider/provider.dart';

class MyItinerariesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.authService.authStatus == AuthStatus.AUTHENTICATED) {
        return FutureBuilder<List<Itinerary>>(
            future: appState.getMyItinerariesList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Itinerary>> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    ListView(
                      children: snapshot.data
                          .map((itinerary) =>
                              ImageLeftTextRightWidget(itinerary: itinerary))
                          .toList(),
                    ),
                    Positioned(
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          backgroundColor: ColorConstants.BACKGROUND_DARK_BLUE,
                          onPressed: null,
                        ),
                        bottom: 30,
                        right: 30),
                  ],
                );
              } else {
                return Container();
              }
            });
      } else {
        return Center(
          child: MaterialButton(
            child: Text(
              '点击登录',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Router.push(context, Router.loginPage, {});
            },
          ),
        );
      }
    });
  }
}
