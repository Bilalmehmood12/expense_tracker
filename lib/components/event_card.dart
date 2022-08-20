import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.event}) : super(key: key);

  final Event event;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd MMM, yyy");
    DateFormat timeFormat = DateFormat("hh:mm a");
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 3)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: Icon(
                      event.type == "Income"
                          ? Icons.keyboard_double_arrow_right_rounded
                          : Icons.keyboard_double_arrow_left_rounded,
                      color: event.type == "Income" ? Colors.green : Colors.red,
                      size: 35,
                    ))),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    event.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    event.des,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 12),
                  ),
                  const Spacer(),
                  Text(
                    '${dateFormat.format(event.date)} at ${timeFormat.format(event.date)}',
                    style: TextStyle(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 3,
                child: Text(
                  event.amount,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
