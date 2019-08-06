import 'package:flutter/material.dart';
import 'package:link_previewer/link_previewer.dart';

Widget build() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      LinkPreviewer(
        link: "https://www.linkedin.com/feed/",
        direction: ContentDirection.horizontal,
      ),
      LinkPreviewer(
        link: "https://www.linkedin.com/feed/",
        direction: ContentDirection.vertical,
      ),
    ],
  );
}
