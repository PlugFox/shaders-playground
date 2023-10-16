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
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: _CardWithShimmers(),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 128),
                        child: SizedBox(
                          width: 92,
                          height: 64,
                          child: RoundedRectangle(
                            radius: 16,
                            color: Color(0x7F00FF00),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 128),
                        child: SizedBox(
                          width: 64,
                          height: 92,
                          child: RoundedRectangle(
                            radius: 16,
                            color: Color(0x7F0000FF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              color: Colors.indigo,
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
