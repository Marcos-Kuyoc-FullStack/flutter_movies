import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CardSwiper(),
            // Slider de peliculas
            MovieSlider()
          ],
        ),
      ),
    );
  }
}
