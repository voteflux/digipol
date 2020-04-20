import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/viewmodels/all_bills_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/bill_list_item.dart';

class AllBillsPage extends StatefulWidget {
  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}


// Where all the bills are shown (using ListView)
TextEditingController _textController = TextEditingController();

class _AllBillsPageState extends State<AllBillsPage> {
  Api _api = locator<Api>();
  List<Bill> _filterBills;
  List<Bill> _billList;
  ScrollController controller;
  var listItemAmount = 20;

  Future getBills() async {
    _billList = await _api.getBills();

    setState(() {
      _filterBills = _billList;
    });
  }
  
  // TODO Move search logic to core

  void _filterList(value) {
    setState(() {
      _filterBills = _billList
          .where((text) =>
              text.shortTitle.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getBills();
    controller = ScrollController()..addListener(_scrollListener);
  }

    @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // TODO: When scroll gets to 100 from bottom, add to listItem
  void _scrollListener() {
    print(controller.position.extentAfter);
    print('printeing');
    if (controller.position.extentAfter < 100) {
      setState(() {
        listItemAmount = listItemAmount + 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BillsModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, 
          elevation: 0,
          title: InkWell(
            child: TextField(
              autofocus: false,
              enableInteractiveSelection: false,
              controller: _textController,
              onChanged: (value) {
                _filterList(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search Bills",
                border: InputBorder.none
                ),
            ),
          ),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: ListView(
                  controller: ScrollController(),
                  children: <Widget>[
                    //CountUpWidget(
                    //    number: model.bills.length, text: "TOTAL BILLS"),
                    //BillsMessageWidget(),
                    billsList(_filterBills, listItemAmount, controller)
                  ],
                ),
              ),
      ),
    );
  }
}

Widget billsList(List<Bill> bills, int itemCountAmount, ScrollController controller) => ListView.builder(
    itemCount: itemCountAmount,
    controller: controller,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemBuilder: (context, index) => BillListItem(bill: bills[index]));

class BillsMessageWidget extends StatelessWidget {
  /// Card for showing a message at the top of the bills list
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appSizes.cardCornerRadius),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 0, vertical: appSizes.standardMargin),
        elevation: appSizes.cardElevation,
        color: appColors.card,
        child: Container(
          padding: EdgeInsets.all(appSizes.standardPadding),
          width: appSizes.smallWidth,
          child: Column(
            children: <Widget>[
              Text(
                "A list of all Federal Bills",
                style: appTextStyles.smallBold,
              ),
              Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage('assets/graphics/point.png')),
              ),
              Text(
                "Vote on the Bills by scrolling and tapping on the Bills that matter most to you",
                style: appTextStyles.smallBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}