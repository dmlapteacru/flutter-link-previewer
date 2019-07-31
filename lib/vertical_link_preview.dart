part of link_previewer;

class VerticalLinkPreview extends StatelessWidget {
  VerticalLinkPreview({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    @required this.imageWidth,
    @required this.imageHeight,
    @required this.onTap,
  })  : assert(imageUri != null),
        assert(title != null),
        assert(url != null),
        assert(description != null),
        assert(imageHeight != null),
        assert(imageWidth != null),
        assert(onTap != null),
        super(key: key);

  final String url;
  final String title;
  final String description;
  final String imageUri;
  final double imageWidth;
  final double imageHeight;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(url),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Image.network(
              imageUri,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
            flex: 2,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 4.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                      child: Container(
                        alignment: Alignment(-1.0, -1.0),
                        child: Text(
                          description,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
