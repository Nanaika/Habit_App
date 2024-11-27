import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/theme.dart';

import '../components/custom_button.dart';
import '../utils/const.dart';
import 'onboarding_page2.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defPaddingH),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
                    child: Image.asset('assets/images/square.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome to BalanceHer!',
                    style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your assistant in creating harmony and development!',
                    style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                child: SafeArea(
                  bottom: true,
                  child: CustomButton(
                    text: 'Next',
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                        return const OnboardingPage2();
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
