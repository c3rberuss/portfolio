import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/user/bloc.dart';
import 'package:services/src/presentation/widgets/card.dart';
import 'package:services/src/utils/screen_utils.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Wrap(
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (BuildContext context, UserState state) {
                return Container(
                  width: getScreenWidth(context) * .9,
                  height: getScreenHeight(context) * .5,
                  child: CustomCard(
                    content: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/user.png"),
                            radius: 50,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            state.data.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(state.data.email),
                          SizedBox(height: 25),
                          Text(
                            "Another info",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
