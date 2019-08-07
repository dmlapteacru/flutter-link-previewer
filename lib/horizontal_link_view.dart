part of link_previewer;

class HorizontalLinkView extends StatelessWidget {
  HorizontalLinkView({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    @required this.onTap,
    this.titleFontSize,
    this.bodyFontSize,
    this.showTitle,
    this.showBody,
  })  : assert(imageUri != null),
        assert(title != null),
        assert(url != null),
        assert(description != null),
        assert(onTap != null),
        super(key: key);

  final String url;
  final String title;
  final String description;
  final String imageUri;
  final Function onTap;
  final double titleFontSize;
  final double bodyFontSize;
  final bool showTitle;
  final bool showBody;

  double computeTitleFontSize(double width) {
    double size = width * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight) {
    return layoutHeight >= 100 ? 2 : 1;
  }

  int computeBodyLines(layoutHeight) {
    return layoutHeight ~/ 25 == 0 ? 1 : layoutHeight ~/ 25;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var _titleFontSize = titleFontSize == null
          ? computeTitleFontSize(layoutWidth)
          : titleFontSize;
      var _bodyFontSize = bodyFontSize == null
          ? computeTitleFontSize(layoutWidth) - 1
          : bodyFontSize;

      return InkWell(
        onTap: () => onTap(url),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUri), fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: showBody == false
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: <Widget>[
                  showTitle == false
                      ? Container()
                      : _buildTitleContainer(
                          _titleFontSize, computeTitleLines(layoutHeight)),
                  showBody == false
                      ? Container()
                      : _buildBodyContainer(
                          _bodyFontSize, computeBodyLines(layoutHeight))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTitleContainer(_titleFontSize, _maxLines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 3.0, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment(-1.0, -1.0),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: _titleFontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContainer(_bodyFontSize, _maxLines) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: Column(
          mainAxisAlignment: showTitle == false
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment(-1.0, -1.0),
              child: Text(
                description,
                style: TextStyle(fontSize: _bodyFontSize, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: _maxLines,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
