import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/pages/main_page_view.dart';
import 'package:habit_app/theme.dart';

import '../components/custom_button.dart';
import 'onboarding_page1.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

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
                    child: Image.asset('assets/images/circle.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Start your journey to harmony today!',
                    style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                child: SafeArea(
                  bottom: true,
                  child: CustomButton(
                    text: 'Get started',
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                        return MainPageView();
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
