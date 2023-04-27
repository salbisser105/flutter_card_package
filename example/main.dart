import 'package:card_package/card_package.dart';
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
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Page1'),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: CustomCreditCardWidget(
                cardNumber: '',
                expiryDate: '',
                cardHolderName: '',
                cvvCode: '',
                showBackView: true,
                onCreditCardWidgetChange: (CreditCardBrand) {})));
  }
}
