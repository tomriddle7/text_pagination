library text_pagination;

import 'dart:ui';
import 'package:flutter/material.dart';

class Pagination {
  static String _rawText = '';
  static List<num> _textIdx = [];

  static double _pageHeight = MediaQueryData.fromWindow(window).size.height;
  static double _pageWidth = MediaQueryData.fromWindow(window).size.width;
  static String _fontName = 'Roboto';
  static double _fontSize = 26.0;
  static double _letterSpacig = 3.0;
  static double _height = 1.5;

  static int pageLength()  {
    return _textIdx.length;
  }

  static String pageText(int value) {
    int start = value == 0 ? 0 : _textIdx[value - 1];
    int end = _textIdx[value];
    return _rawText.substring(start, end);
  }

  static bool setStyle(String font, double fSize, double lSpacing, double fHeight) {
    return setPage(_rawText, _pageHeight, _pageWidth, font, fSize, lSpacing, fHeight);
  }

  static bool setPage(String text, double pgHeight, double pgWidth,
      String font, double fSize, double lSpacing, double fHeight) {
    _rawText = text;
    _textIdx.clear();

    _pageHeight = pgHeight;
    _pageWidth = pgWidth;
    _fontName = font;
    _fontSize = fSize;
    _letterSpacig = lSpacing;
    _height = fHeight;

    TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textScaleFactor: MediaQueryData.fromWindow(window).textScaleFactor);

    textPainter.text = TextSpan(
      text: '가',
      style: TextStyle(
          fontFamily: font,
          fontSize: fSize,
          letterSpacing: lSpacing,
          height: fHeight),
    );

    textPainter.layout(maxWidth: pgWidth);
    double lineHeight = textPainter.preferredLineHeight;
    double charWidth = textPainter.width;
    int lineNumberPerPage = (pgHeight ~/ lineHeight) - 1;
    int charNumberPerLine = (pgWidth ~/ charWidth) - 1;
    _getPageOffsets(text, lineNumberPerPage, charNumberPerLine).listen((value) {
      _textIdx.add(value);
    });
    return true;
  }

  static Stream<int> _getPageOffsets(
      String text, int lineNumber, int charNumber) async* {
    num lineText = 0;
    int lineCount = 0;

    if (text.isNotEmpty) {
      int i = 0;
      while (true) {
        if (lineCount >= lineNumber) {
          lineCount = 0;
          yield i;
        }

        if (text[i].contains(new RegExp(r'[A-Za-z0-9 ,.<>/?!@#$%^&*()-_=+\\|]'))) {
          lineText += 0.5;
        } else
          lineText += 1;

        if (lineText >= charNumber || text[i] == '\n') {
          lineText = 0;
          lineCount++;
        }
        if (i == text.length - 1)
          break;
        else
          i++;
      }
      if (lineText > 0) {
        yield i;
      }
    }
  }
}
