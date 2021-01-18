import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/viewmodels/all_issues_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/issue_list_item.dart';

class ProfileHubPage extends StatefulWidget {
  @override
  _ProfileHubPageState createState() => _ProfileHubPageState();
}

TextEditingController _textController = TextEditingController();

class _ProfileHubPageState extends State<ProfileHubPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<IssuesModel>(
      onModelReady: (model) => model.getIssues(),
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
                model.searchIssues(value);
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  fillColor: appColors.text,
                  hintText: "Search Issues",
                  border: InputBorder.none),
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
                    //    number: model.issues.length, text: "TOTAL BILLS"),
                    issues(model.issueList)
                  ],
                ),
              ),
      ),
    );
  }
}

Widget issues(List<BlockChainData> issues) => ListView.builder(
    itemCount: issues.length,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemBuilder: (context, index) =>
        IssueListItem(blockChainData: issues[index]));
