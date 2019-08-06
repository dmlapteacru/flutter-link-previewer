part of link_previewer;

class HorizontalLinkView extends StatelessWidget {
  HorizontalLinkView({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    this.titleFontSize,
    this.bodyFontSize,
    @required this.onTap,
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

  double calculateTitleFontSize(double width) {
    double size = width * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var _titleFontSize = titleFontSize == null
          ? calculateTitleFontSize(layoutWidth)
          : titleFontSize;
      var _bodyFontSize = bodyFontSize == null
          ? calculateTitleFontSize(layoutWidth) - 1
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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 3.0, 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment(-1.0, -1.0),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _titleFontSize),
                            overflow: TextOverflow.ellipsis,
                            maxLines: layoutHeight >= 100 ? 2 : 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 0.0),
                      child: Container(
                        alignment: Alignment(-1.0, -1.0),
                        child: Text(
                          description,
                          style: TextStyle(
                              fontSize: _bodyFontSize, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: layoutHeight ~/ 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
