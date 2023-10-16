import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/src/rrect.dart';
import 'package:shimmer/src/shimmer.dart';

void main() => runZonedGuarded<void>(
      () => runApp(const App()),
      (error, stackTrace) => log('Top level exception $error'),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Shimmer shader',
        theme: ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Shimmer shader'),
          ),
          body: const SafeArea(
            child: Stack(
              children: <Widget>[
                Center(
                  child: _CardWithShimmers(),
                ),
                Align(
                  alignment: Alignment(-.15, -.25),
                  child: SizedBox(
                    width: 128,
                    height: 64,
                    child: RoundedRectangle(
                      radius: 0,
                      color: Color(0x7F00ff00),
                      borderWidth: 2,
                      borderColor: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-.15, .25),
                  child: SizedBox(
                    width: 64,
                    height: 128,
                    child: RoundedRectangle(
                      radius: 0,
                      color: Color(0x7F0000ff),
                      borderWidth: 0,
                      borderColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _CardWithShimmers extends StatelessWidget {
  const _CardWithShimmers();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Shimmer(),
            SizedBox(height: 8),
            Shimmer(
              size: Size(64, 28),
              color: Colors.red,
              backgroundColor: Colors.indigo,
              speed: 25,
            ),
            SizedBox(height: 8),
            Shimmer(
              size: Size.square(128),
              cornerRadius: 48,
              speed: 5,
              color: Colors.amber,
            ),
            SizedBox(height: 8),
            Shimmer(
              color: Colors.red,
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 8),
            Shimmer(
              size: Size.fromRadius(48),
              cornerRadius: 32,
              color: Colors.red,
            ),
            SizedBox(height: 8),
            Shimmer(
              speed: 15,
              stripeWidth: .1,
              backgroundColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
