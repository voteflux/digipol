import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/viewmodels/all_issues_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/issue_list_item.dart';

class AllIssuesPage extends StatefulWidget {
  @override
  _AllIssuesPageState createState() => _AllIssuesPageState();
}

TextEditingController _textController = TextEditingController();

class _AllIssuesPageState extends State<AllIssuesPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<IssuesModel>(
      onModelReady: (model) => model.getIssues(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(50, 120),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      'Issues',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
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
