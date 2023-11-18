import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

List<Map<String, dynamic>> TransactionData = [
  {
    'icon': FaIcon(
      FontAwesomeIcons.burger,
      color: Colors.white,
    ),
    'color': Colors.yellow[700],
    'name': 'Food',
    'totalAmount': '-\₹50',
    'date': 'Today',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '-\₹200',
    'date': 'Today',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '-\₹120',
    'date': 'Yesterday',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.plane, color: Colors.white),
    'color': Colors.blue,
    'name': 'Travel',
    'totalAmount': '-\₹150',
    'date': 'Yesterday',
  },
];
