import 'package:expense_tracker/ui/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'src/expense.png',
                scale: 10,
                color: Theme.of(context).primaryColorDark,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Expense Tracker",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColorDark),
              ),
              const Spacer(),
            ],
          ),
        )));
  }

  @override
  void initState() {
    super.initState();

    homeScreen();
  }
  void homeScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
