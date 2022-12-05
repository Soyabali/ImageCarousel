import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // take a index photo
  int photoIndex = 0;
  // store photo in a list
  List<String> photos = [
    'assets/images/burger1.jpg',
    'assets/images/burger2.jpg',
    'assets/images/burger3.jpg',
    'assets/images/burger4.jpg'
  ];

  void _previousImage() {
    setState(() {
      // previousImage logic
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      // next image logic
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Carousel'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage(photos[photoIndex]),
                            fit: BoxFit.cover)),
                    height: 400.0,
                    width: 300.0,
                  ),
                  Positioned(
                    top: 375.0,
                    left: 25.0,
                    right: 25.0,
                    child: SelectedPhoto(numberOfDots: photos.length, photoIndex: photoIndex),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Next'),
                  onPressed: _nextImage,
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  child: Text('Prev'),
                  onPressed: _previousImage,
                )
              ],
            )
          ],
        ));
  }
}
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  const SelectedPhoto({super.key, required this.numberOfDots, required this.photoIndex});

  Widget _inactivePhoto() {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4.0)
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.0,
              blurRadius: 2.0
            )
          ]
        ),
      ),
    );
  }
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for(int i = 0; i< numberOfDots; ++i) {
      dots.add(
        i == photoIndex ? _activePhoto(): _inactivePhoto()
      );
    }
    return dots;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
