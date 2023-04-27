import 'package:card_package/card_package.dart';
import 'package:card_package/glassmorphism_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'page1',
      routes: {
        'page1': ((context) => const Page1()),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Page1'),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: CustomCreditCardWidget(
            padding: 6,
            height: height * 0.215,
            cardBgColor: Colors.green,
            obscureCardNumber: false,
            obscureCardCvv: false,
            chipSizedBoxHeight: 20,
            sizedBoxCardName: 20,
            sizedBoxCardNumber: 20,
            cardNumber: '4444 4444 4444',
            expiryDate: '05/26',
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: 14, color: Colors.red),
            cardHolderName: 'Santiago Albisser',

            glassmorphismConfig: Glassmorphism(
              blurX: 40.0,
              blurY: 25.0,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blueGrey, Colors.blue],
                stops: const <double>[
                  0.5,
                  0,
                ],
              ),
            ),
            /*'${authState.userName} ${authState.userLastName}',*/
            isHolderNameVisible: false,
            isChipVisible: true,
            cvvCode: '424',
            showBackView: true,
            onCreditCardWidgetChange:
                (CreditCardBrand) {}, //true when you want to show cvv(back) view
          ),

          //  CustomCreditCardWidget(
          //     cardNumber: '',
          //     expiryDate: '',
          //     cardHolderName: '',
          //     cvvCode: '4235',
          //     showBackView: true,
          //     onCreditCardWidgetChange: (CreditCardBrand) {})
        ));
  }
}
