library link_previewer;

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' hide Text;
import 'package:flutter/material.dart' hide Element;
import 'dart:async';
import 'dart:convert';

part 'parser/web_page_parser.dart';

part 'package:link_previewer/horizontal_link_view.dart';

part 'package:link_previewer/vertical_link_preview.dart';

part 'package:link_previewer/content_direction.dart';

class LinkPreviewer extends StatefulWidget {
  LinkPreviewer({
    Key key,
    @required this.link,
    this.titleFontSize,
    this.bodyFontSize,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.deepOrangeAccent,
    this.borderRadius,
    this.direction = ContentDirection.horizontal,
  })  : assert(link != null),
        super(key: key);

  final String link;
  final double titleFontSize;
  final double bodyFontSize;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final ContentDirection direction;

  @override
  _LinkPreviewer createState() => _LinkPreviewer();
}

class _LinkPreviewer extends State<LinkPreviewer> {
  Map _metaData;
  double _height;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  double _calculateHeight(double screenHeight) {
    if (widget.direction == ContentDirection.horizontal) {
      return screenHeight * 0.12;
    } else {
      return screenHeight * 0.25;
    }
  }

  void _fetchData() {
    if (!isValidUrl(widget.link)) {
      throw Exception("Invalid link");
    } else {
      _getMetaData(widget.link);
    }
  }

  void _getMetaData(link) async {
    Map data = await WebPageParser.getData(link);
    if (data != null) {
      setState(() {
        _metaData = data;
      });
    } else {
      setState(() {
        _metaData = null;
      });
    }
  }

  bool isValidUrl(link) {
    String regexSource =
        "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    final regex = RegExp(regexSource);
    final matches = regex.allMatches(link);
    for (Match match in matches) {
      if (match.start == 0 && match.end == link.length) {
        return true;
      }
    }
    return false;
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = _calculateHeight(MediaQuery.of(context).size.height);

    return _metaData == null
        ? Container()
        : Container(
            decoration: new BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(
                color: widget.borderColor == null
                    ? widget.backgroundColor
                    : widget.borderColor,
                width: widget.borderColor == null ? 0.0 : 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 3.0 : widget.borderRadius)),
            ),
            height: _height,
            child: _buildLinkView(
              widget.link,
              _metaData['title'] == null ? "" : _metaData['title'],
              _metaData['description'] == null ? "" : _metaData['description'],
              _metaData['image'] == null ? "" : _metaData['image'],
              _launchURL,
            ),
          );
  }

  Widget _buildLinkView(link, title, description, imageUri, onTap) {
    if (widget.direction == ContentDirection.horizontal) {
      return HorizontalLinkView(
        url: link,
        title: title,
        description: description,
        imageUri: imageUri,
        onTap: onTap,
      );
    } else {
      return VerticalLinkPreview(
        url: link,
        title: title,
        description: description,
        imageUri: imageUri,
        onTap: onTap,
      );
    }
  }
}
