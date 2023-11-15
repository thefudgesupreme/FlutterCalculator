import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int num1 = 0, num2 = 0;
  num ans = 0;

  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  late final AppLifecycleListener _listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayOneController.text = num1.toString();
    displayTwoController.text = num2.toString();

    _listener = AppLifecycleListener(
      onShow: _onShow,
      onHide: _onHide,
      onResume: _onResume,
      onDetach: _onDetach,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onStateChange: _onStateChange,
      // onExitRequested: _onExitRequested,
    );
  }

  void _onShow() => print("onShow called");

  void _onHide() => print("onHide called");

  void _onResume() => print("onResume called");

  void _onDetach() => print("onDetach called");

  void _onInactive() => print("onInactive called");

  void _onPause() => print("onPause called");

  void _onRestart() => print("onRestart called");

  void _onStateChange(AppLifecycleState state) =>
      print("onStateChanged called with state $state");

  @override
  void dispose() {
    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Calculator Display
          DisplayInput(
              key: const Key("Number1"),
              hint: "Enter First Number",
              controller: displayOneController),
          const SizedBox(
            height: 30,
          ),
          DisplayInput(
              key: const Key("Number2"),
              hint: "Enter Second Number",
              controller: displayTwoController),
          const SizedBox(
            height: 30,
          ),

          Text(
            key: const Key("Answer"),
            ans.toString(),
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 75,
                fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      ans = num.tryParse(displayOneController.text)! +
                          num.tryParse(displayTwoController.text)!;
                    });
                  },
                  child: const Icon(CupertinoIcons.add)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      ans = num.tryParse(displayOneController.text)! -
                          num.tryParse(displayTwoController.text)!;
                    });
                  },
                  child: const Icon(CupertinoIcons.minus)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      ans = num.tryParse(displayOneController.text)! *
                          num.tryParse(displayTwoController.text)!;
                    });
                  },
                  child: const Icon(CupertinoIcons.multiply)),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      ans = num.tryParse(displayOneController.text)! /
                          num.tryParse(displayTwoController.text)!;
                    });
                  },
                  child: const Icon(CupertinoIcons.divide)),
            ],
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  num1 = num2 = ans = 0;
                  displayOneController.clear();
                  displayTwoController.clear();
                });
              },
              label: const Text(
                "Clear",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              )),

          // Expand
          // Calculator Buttons
        ],
      ),
    );
  }
}

class DisplayInput extends StatelessWidget {
  const DisplayInput(
      {super.key, this.hint = "Enter a Number", required this.controller});

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.indigoAccent, width: 5.0),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.indigoAccent, width: 5.0),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
