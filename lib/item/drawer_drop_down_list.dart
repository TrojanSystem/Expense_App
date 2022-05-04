import 'package:example/constants.dart';
import 'package:flutter/material.dart';

class DrawerDropDownListItems extends StatefulWidget {
  final String title;
  final String listItem1;
  final String listItem2;
  final Function buttonPressed;
  final Function buttonPressedDetail;

  DrawerDropDownListItems(
      {this.buttonPressed,
      this.title,
      this.listItem1,
      this.listItem2,
      this.buttonPressedDetail});

  @override
  State<DrawerDropDownListItems> createState() =>
      _DrawerDropDownListItemsState();
}

class _DrawerDropDownListItemsState extends State<DrawerDropDownListItems> {
  bool isTapped = true;

  double totalSumation = 0.00;

  bool isNegative = false;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      onHighlightChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: AnimatedContainer(
              //padding: const EdgeInsets.only(left: 8.0, right: 8),
              // margin: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     const Color.fromRGBO(3, 83, 151, 1),
                  //     const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.9)
                  //   ],
                  // ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.5),
                  //     blurRadius: 4,
                  //     offset: const Offset(4, 8), // changes position of shadow
                  //   ),
                  // ],
                  ),
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isTapped
                  ? isExpanded
                      ? 100
                      : 60
                  : isExpanded
                      ? 200
                      : 150,
              width: isExpanded ? 345 : 350,
              child: isTapped
                  ? Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            // padding: const EdgeInsets.only(top: 10, left: 5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.blue,
                            //     width: 2,
                            //   ),
                            // ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.title,
                                        style: kkExpense,
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          isTapped
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.black,
                          size: 27,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              widget.title,
                                              style: kkExpense,
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        )),
                                    Container(
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              isTapped
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: Colors.black,
                              size: 27,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: widget.buttonPressed,
                                    child: Text(
                                      widget.listItem1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: widget.buttonPressedDetail,
                                    child: Text(
                                      widget.listItem2,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   SummaryExpenseList(index: widget.index,listMonth: monthOfYear,)
                            ],
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
