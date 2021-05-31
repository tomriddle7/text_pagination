library text_pagination;

import 'dart:ui';
import 'package:flutter/material.dart';

class Pagination {
  static String _rawText = '';
  static List<num> _textIdx = [];

  static String fontName = 'Roboto';
  static double fontSize = 26.0;
  static double letterSpacig = 3.0;
  static double height = 1.5;

  static int pageLength()  {
    return _textIdx.length;
  }

  static String pageText(int value) {
    int start = value == 0 ? 0 : _textIdx[value - 1];
    int end = _textIdx[value];
    return _rawText.substring(start, end);
  }

  static bool setPage(String text, double pageHeight, double pageWidth,
      String font, double fSize, double lSpacing, double fHeight) {
    _rawText = text;
    _textIdx.clear();

    fontName = font;
    fontSize = fSize;
    letterSpacig = lSpacing;
    height = fHeight;

    TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textScaleFactor: MediaQueryData.fromWindow(window).textScaleFactor);

    textPainter.text = TextSpan(
      text: '가',
      style: TextStyle(
          locale: Locale('en_EN'),
          fontFamily: fontName,
          fontSize: fontSize,
          letterSpacing: letterSpacig,
          height: height),
    );

    textPainter.layout(maxWidth: pageWidth);
    double lineHeight = textPainter.preferredLineHeight;
    double charWidth = textPainter.width;
    int lineNumberPerPage = (pageHeight ~/ lineHeight) - 1;
    int charNumberPerLine = (pageWidth ~/ charWidth) - 1;
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

        if (text[i].contains(new RegExp(r'[A-Za-z ]'))) {
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
