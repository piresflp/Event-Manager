import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YourEvents extends StatefulWidget {
  @override
  _YourEventsState createState() => _YourEventsState();
}

class _YourEventsState extends State<YourEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFF5F4EF),
              image: DecorationImage(
                image: AssetImage("assets/images/ux_big.png"),
                alignment: Alignment.topRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset("assets/icons/arrow-left.svg"),
                              SvgPicture.asset("assets/icons/more-vertical.svg")
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Seus Eventos",
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xFF0D1333),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            SvgPicture.asset("assets/icons/person.svg"),
                            SizedBox(width: 5),
                            Text("#12312"),
                            SizedBox(width: 20),
                            SvgPicture.asset("assets/icons/star.svg"),
                            SizedBox(width: 5),
                            Text("5")
                          ]),
                        ])),
                SizedBox(height: 60),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Course content",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0D1333),
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 30),
                              EventContent(
                                number: "01",
                                duration: 5.35,
                                title: "Teste!!!",
                                isDone: true,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                              padding: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 50,
                                        color:
                                            Color(0xFF0D1333).withOpacity(.1))
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(14),
                                    height: 56,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFEDEE),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: SvgPicture.asset(
                                        "assets/icons/shopping-bag.svg"),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class EventContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;

  const EventContent({
    Key? key,
    this.number = "",
    this.duration = 0,
    this.title = "",
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(number,
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0D1333).withOpacity(.5),
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 20),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "$duration mins\n",
                style: TextStyle(
                    color: Color(0xFF0D1333).withOpacity(.5), fontSize: 18)),
            TextSpan(
                text: title,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D1333),
                    fontWeight: FontWeight.w600,
                    height: 1.5))
          ])),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF49CC96).withOpacity(isDone ? 1 : 5)),
            child: Icon(Icons.play_arrow, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
