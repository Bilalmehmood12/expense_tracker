import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pie_chart/pie_chart.dart';

import '../components/event_card.dart';
import '../constants/constant.dart';
import '../database/event_database.dart';
import 'add_new_event_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (Constants.events.isNotEmpty) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PieChart(
                          dataMap: {
                            "Expense": Constants.expense,
                            "Income": Constants.income,
                            "Saving": Constants.income - Constants.expense,
                          },
                          colorList: [
                            Colors.red.shade400,
                            Colors.green.shade400,
                            Colors.grey.shade400.withOpacity(0.5)
                          ],
                          chartType: ChartType.ring,
                          chartLegendSpacing:
                              MediaQuery.of(context).size.width / 6,
                        )
                      ],
                    )),
                Expanded(
                    flex: 7,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          children: List.generate(
                              Constants.events.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Slidable(
                                        key: Key(index.toString()),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddNewEvent(
                                                                event: Constants
                                                                        .events[
                                                                Constants.events.length -
                                                                    index - 1])));
                                                await Constants.readAll();
                                                setState(() {});
                                              },
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              icon: Icons.edit_outlined,
                                              label: "Edit",
                                            ),
                                            SlidableAction(
                                              onPressed: (context) async {
                                                await EventDatabase.instance
                                                    .delete(Constants
                                                        .events[Constants.events.length -
                                                    index - 1].id!);
                                                await Constants.readAll();
                                                setState(() {});
                                              },
                                              backgroundColor:
                                                  Colors.red.withOpacity(0.9),
                                              icon: Icons.delete_outlined,
                                              label: "Delete",
                                            ),
                                          ],
                                        ),
                                        child: EventCard(
                                            event: Constants.events[
                                                Constants.events.length -
                                                    index - 1])),
                                  )),
                        ))),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNewEvent()));
            await Constants.readAll();
            setState(() {});
          },
          tooltip: "Add New Event",
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).primaryColor,
        body: const Center(
          child: Text("There is no entry"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNewEvent()));
            await Constants.readAll();
            setState(() {});
          },
          tooltip: "Add New Event",
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    Constants.readAll().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
