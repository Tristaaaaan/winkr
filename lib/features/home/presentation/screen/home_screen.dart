import 'package:flutter/material.dart';
import 'package:winkr/features/home/presentation/widget/proceed_button.dart';

import '../../../../commons/widgets/filter_chip/filter_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Winkr!',
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'To proceed, kindly select the platform where you want to use bio.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15),
              ChipFilter(),
              SizedBox(height: 15),
              Align(alignment: Alignment.centerRight, child: ProceedButton()),
            ],
          ),
        ),
      ),
    );
  }
}
