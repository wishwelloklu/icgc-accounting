import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String text;
  final String fontName;
  final String searchText;
  final double fontSize;
  final int? maxLine;
  const CustomeText({
    super.key,
    this.maxLine,
    required this.text,
    required this.fontSize,
    required this.searchText,
    required this.fontName,
  });

  List<TextSpan> parseText(String text) {
    final regex = RegExp(r'(\*b(.*?)\*b)|(\*t(.*?)\*t)|(\*cc(.*?)\*cc)');
    final matches = regex.allMatches(text);

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      // Add non-styled text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(fontSize: fontSize, fontFamily: fontName)));
      }

      // Apply style based on the detected group
      if (match.group(2) != null) {
        // Bold

        spans.addAll(_highlightSearchText(
            match.group(2)!,
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: fontName,
            )));
      } else if (match.group(4) != null) {
        // Italic
        spans.addAll(_highlightSearchText(
            match.group(4)!,
            TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: fontSize,
                fontFamily: fontName)));
      }

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.addAll(
        _highlightSearchText(
          text.substring(lastMatchEnd),
          TextStyle(fontSize: fontSize, fontFamily: fontName),
        ),
      );
    }

    return spans;
  }

  List<TextSpan> _highlightSearchText(String text, [TextStyle? baseStyle]) {
    if (searchText.isEmpty) {
      // No searchText, return as is
      return [TextSpan(text: text, style: baseStyle)];
    }

    final searchRegex = RegExp(RegExp.escape(searchText), caseSensitive: false);
    final matches = searchRegex.allMatches(text);

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      // Add normal text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: baseStyle ??
                TextStyle(fontSize: fontSize, fontFamily: fontName)));
      }

      // Add highlighted text
      spans.add(TextSpan(
        text: match.group(0),
        style:
            (baseStyle ?? TextStyle(fontSize: fontSize, fontFamily: fontName))
                .copyWith(backgroundColor: Colors.yellow),
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
          text: text.substring(lastMatchEnd),
          style: baseStyle ??
              TextStyle(fontSize: fontSize, fontFamily: fontName)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: parseText(text)),
      maxLines: maxLine,
    );
  }
}

List<TextSpan> parseText(String text) {
  // Updated regex to handle bold (*b) and italic (*t) text
  final regex = RegExp(r'(\*b(.*?)\*b)|(\*t(.*?)\*t)|(\*cc(.*?)\*cc)');
  final matches = regex.allMatches(text);

  List<TextSpan> spans = [];
  int lastMatchEnd = 0;

  for (final match in matches) {
    // Add non-styled text before the match
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
      ));
    }

    // Apply style based on the detected group
    if (match.group(2) != null) {
      // Bold
      spans.add(TextSpan(
        text: match.group(2),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
    } else if (match.group(4) != null) {
      // Italic
      spans.add(TextSpan(
        text: match.group(4),
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ));
    }

    lastMatchEnd = match.end;
  }

  // Add remaining text after the last match
  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastMatchEnd),
    ));
  }

  return spans;
}

String extractTextFromTextSpan(TextSpan textSpan) {
  StringBuffer buffer = StringBuffer();

  void traverseSpan(TextSpan span) {
    if (span.text != null) {
      buffer.write(span.text);
    }
    if (span.children != null) {
      for (var child in span.children!) {
        traverseSpan(child as TextSpan);
      }
    }
  }

  traverseSpan(textSpan);
  return buffer.toString();
}
