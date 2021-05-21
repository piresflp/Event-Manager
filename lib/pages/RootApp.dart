import 'AddEvent.dart';
import 'Chat/ChatPage.dart';
import 'Invites/InvitesPage.dart';
import 'YourEvents/YourEventsPage.dart';
import '../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [InvitesPage(), AddEvent(), YourEvents(), ChatPage()];

    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List bottomItems = [
      "assets/images/Invite.svg",
      "assets/images/Add.svg",
      "assets/images/Calendar.svg",
      "assets/images/Calendar.svg"
    ];
    List textItems = ["Convites", "Criar", "Seus Eventos", "Chat"];
    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
          color: white,
          border: Border(
              top: BorderSide(width: 2, color: black.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      bottomItems[index],
                      width: 22,
                      color: pageIndex == index ? black : Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                          fontSize: 10,
                          color: pageIndex == index
                              ? black
                              : black.withOpacity(0.5)),
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
