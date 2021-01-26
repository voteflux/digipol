import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/viewmodels/all_issues_model.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/bill_list_item.dart';
import 'package:voting_app/ui/widgets/issue_list_item.dart';

class ProfileHubPage extends StatefulWidget {
  @override
  _ProfileHubPageState createState() => _ProfileHubPageState();
}

TextEditingController _textController = TextEditingController();

class _ProfileHubPageState extends State<ProfileHubPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      onModelReady: (model) => model.getBills(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size(100, 190),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: Icon(Icons.person,
                              size: 38,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        SizedBox(width: 20),
                        Text(
                          model.getUser != null ? model.getUser : '',
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Achievements'),
                            Text(
                              'Coming Soon',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverAppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: false,
              stretch: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(right: 4, left: 10),
                      child: DropdownButton<String>(
                        value: DROPDOWN_FILTER_OPTIONS[0],
                        dropdownColor: Theme.of(context).backgroundColor,
                        underline: SizedBox.shrink(),
                        icon: Icon(Icons.expand_more),
                        iconSize: 24,
                        elevation: 16,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                        onChanged: (String newValue) {
                          setState(() {
                            model.dropDownFilter(newValue);
                          });
                        },
                        items: DROPDOWN_FILTER_OPTIONS
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Row(children: [
                        Text('Voted'),
                        Switch(
                          value: model.pref,
                          inactiveThumbColor:
                              Theme.of(context).colorScheme.secondary,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.secondary,
                          activeColor:
                              Theme.of(context).colorScheme.primaryVariant,
                          onChanged: (value) {
                            setState(() {
                              model.changeSwitch(value);
                            });
                          },
                        ),
                        Text('Watching'),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            key: ObjectKey(model.billList),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return model.billList.length > 0
                    ? BillListItem(billData: model.billList[index])
                    : Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('No bills found',
                            style: Theme.of(context).textTheme.headline6),
                      );
              },
              childCount: model.billList.length,
            ),
          ),
        ]),
      ),
    );
  }
}
