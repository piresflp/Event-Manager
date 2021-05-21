import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class AddEventInvites extends StatefulWidget {
  @override
  _AddEventInvitesState createState() => _AddEventInvitesState();
}

class _AddEventInvitesState extends State<AddEventInvites> {
  var searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Procurar funcionarios'),
        actions: [searchBar.getSearchAction(context)]);
  }

  _AddEventInvitesState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: searchBar.build(context),
        body: Container(
            child: Column(
          children: [
            Row(
              children: [
                InputChip(
                  onPressed: () => null,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(Icons.person),
                  ),
                  label: const Text('Funcionários'),
                ),
                InputChip(
                  onPressed: () => null,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(Icons.people),
                  ),
                  label: const Text('Times'),
                ),
                InputChip(
                  onPressed: () => null,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(Icons.groups),
                  ),
                  label: const Text('Depertamentos'),
                ),
              ],
            ),
          ],
        )));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Text("Invite page"),
  //   );
  // }
}
