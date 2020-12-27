import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/all_bills_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/widgets/bill_list_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllBillsPage extends StatefulWidget {
  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}

TextEditingController _textController = TextEditingController();

class _AllBillsPageState extends State<AllBillsPage> {
  bool _lights = false;
  String dropdownValue = 'Newest';
  @override
  Widget build(BuildContext context) {
    return BaseView<BillsModel>(
      onModelReady: (model) => model.getBills(),
      builder: (context, model, child) {
        print(model.filteredBills);
        return SafeArea(
            child: ValueListenableBuilder(
          valueListenable: model.billsBox.listenable(),
          builder: (context, Box<Bill> billsBox, widget) {
            model.updateLists();
            return Scaffold(
              body: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : CustomScrollView(
                      slivers: <Widget>[
                        SliverSafeArea(
                          top: false,
                          sliver: SliverAppBar(
                            automaticallyImplyLeading: false,
                            floating: true,
                            pinned: false,
                            stretch: true,
                            snap: true,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(50.0),
                              child: Row(
                                // mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ButtonBar(
                                    // alignment: MainAxisAlignment.spaceAround,
                                    // mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: dropdownValue,
                                        underline: SizedBox.shrink(),
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Newest',
                                          'Oldest',
                                          'A-Z'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      RaisedButton.icon(
                                        onPressed: () {},
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        label: Text("Interests"),
                                        icon: Icon(Icons.filter_list),
                                      ),
                                      OutlineButton.icon(
                                        splashColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_drop_up,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        label: Text("Filters"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            title: TextField(
                              controller: _textController,
                              onChanged: (value) {
                                model.searchBills(value);
                              },
                              decoration: InputDecoration(
                                  icon: Icon(Icons.search),
                                  hintText: "Search Bills",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SliverList(
                          key: ObjectKey(model.filteredBills),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext _scbdContext, int index) {
                              if (model.filteredBills.isNotEmpty) {
                                var bill = model.filteredBills[index];
                                print(
                                    '${bill} | ${model.filteredBills.indexOf(bill)} | ${index}');
                              }
                              return model.filteredBills.length > 0
                                  ? BillListItem(
                                      billData: model.filteredBills[index])
                                  : Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text('No bills found',
                                          style: Theme.of(_scbdContext)
                                              .textTheme
                                              .headline6),
                                    );
                            },
                            childCount: max(1, model.filteredBills.length),
                          ),
                        ),
                      ],
                    ),
              endDrawer: Drawer(
                  child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  children: <Widget>[
                    // only voted switch
                    SwitchListTile(
                      title: Text('Only voted'),
                      value: model.getOnlyVotedBills,
                      onChanged: (bool value) {
                        setState(() {
                          model.onlyVotedSearchSave(value);
                        });
                      },
                      secondary: Icon(Icons.done_outline,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    // remove voted switch
                    SwitchListTile(
                      title: Text('Remove voted'),
                      value: model.getRemoveVotedBills,
                      onChanged: (bool value) {
                        setState(() {
                          model.removeVotedSearchSave(value);
                        });
                      },
                      secondary: Icon(Icons.layers_clear,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    // filter by date switch
                    // SwitchListTile(
                    //   title: Text('Sort by date'),
                    //   value: model.getfilterByDate,
                    //   onChanged: (bool value) {
                    //     setState(() {
                    //       model.filterByDateSave(value);
                    //     });
                    //   },
                    //   secondary: Icon(Icons.date_range,
                    //       color: Theme.of(context).iconTheme.color),
                    // ),
                    // filter by date switch
                    SwitchListTile(
                      title: Text('Remove closed bills'),
                      value: model.getRemoveClosedBills,
                      onChanged: (bool value) {
                        setState(() {
                          model.removeClosedBillsFunction(value);
                        });
                      },
                      secondary: Icon(Icons.close,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              )),
            );
          },
        ));
      },
    );
  }
}
