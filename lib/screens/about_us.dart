import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:trial1/helpers/style.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return AboutPage(
        title: Text('About'),
        values: {
          'version': '1.0',
          'year': DateTime.now().year.toString(),
        },
        applicationVersion: '{{ version }}',
        applicationLegalese: 'Copyright © Prajwol Tiwari, {{ year }}',
        applicationDescription: const Text(
            'Medhavi is an cafeteria application which facilitate user to do order from mobile device.'),
        applicationIcon: const SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
          ),
      ),
    );
  }
}
