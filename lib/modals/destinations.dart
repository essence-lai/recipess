import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Recipes', Icons.fastfood),
  Destination('Favourites', Icons.favorite),
  Destination('Community', Icons.face)
];