part of link_previewer;

class HorizontalLinkView extends StatelessWidget {
  HorizontalLinkView({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    @required this.imageHeight,
    @required this.imageWidth,
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
  final Function onTap;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.network(
            imageUri,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
          flex: 1,
        ),
        Expanded(
          child: InkWell(
            onTap: () => onTap(url),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 4.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                      child: Container(
                        alignment: Alignment(-1.0, -1.0),
                        child: Text(
                          description,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
          flex: 3,
        )
      ],
    );
  }
}
