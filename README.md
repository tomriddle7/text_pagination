# text_pagination

This package provides fast text pagination.

## Usage

```dart
class Segmentation extends StatefulWidget {
  @override
  _SegmentationState createState() => _SegmentationState();
}

class _SegmentationState extends State<Segmentation> {
  String rawText = '';
  bool isDone = false;
  int currentPage = 0;
  double fontSize = 26.0;
  double letterSpacing = 3.0;
  double height = 1.5;

  @override
  void initState() {
    loadText();
    super.initState();
  }

  void loadText() async {
    rawText = '''
              Flutter is an open-source UI software development kit created by Google.
              It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia,[4] and the web from a single codebase.[5]
              The first version of Flutter was known as codename "Sky" and ran on the Android operating system.
              It was unveiled at the 2015 Dart developer summit,[6] with the stated intent of being able to render consistently at 120 frames per second.[7]
              During the keynote of Google Developer Days in Shanghai, Google announced Flutter Release Preview 2, which is the last big release before Flutter 1.0.
              On December 4, 2018, Flutter 1.0 was released at the Flutter Live event, denoting the first "stable" version of the Framework.
              On December 11, 2019, Flutter 1.12 was released at the Flutter Interactive event.[8]
              On May 6, 2020, the Dart SDK in version 2.8 and the Flutter in version 1.17.0 were released, where support was added to the Metal API, improving performance on iOS devices (approximately 50%), new Material widgets, and new network tracking.
              On March 3, 2021, Google released Flutter 2 during an online Flutter Engage event.
              This major update brought official support for web-based applications as well as early-access desktop application support for Windows, MacOS, and Linux.[9]
              On March 3, 2021, Google released Flutter 2 during an online Flutter Engage event.
              ''';
    double height = MediaQueryData.fromWindow(window).size.height;
    double width = MediaQueryData.fromWindow(window).size.width;
    setState(() {
      isDone = Pagination.setPage(
          rawText, height, width, 'Roboto', fontSize, letterSpacing, height);
    });
  }

  @override
  Widget build(BuildContext context) => Center(
      child: isDone
          ? Text(
              Pagination.pageText(currentPage),
              style: TextStyle(
                  fontSize: fontSize, letterSpacing: letterSpacing, height: height),
            )
          : Text(
              '',
              style: TextStyle(
                  fontSize: fontSize, letterSpacing: letterSpacing, height: height),
            ));
}
```