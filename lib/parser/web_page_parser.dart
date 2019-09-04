part of link_previewer;

class WebPageParser {
  static Future<Map> getData(String url) async {
    var response = await http.get(url);

    return getDataFromResponse(response, url);
  }

  static Map<dynamic, dynamic> getDataFromResponse(
      http.Response response, String url) {
    var requiredAttributes = ['title', 'image'];
    var data = {};
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      var openGraphMetaTags = _getOgPropertyData(document);

      openGraphMetaTags.forEach((element) {
        var ogTagTitle = element.attributes['property'].split("og:")[1];
        var ogTagValue = element.attributes['content'];
        if ((ogTagValue != null && ogTagValue != "") ||
            requiredAttributes.contains(ogTagTitle)) {
          if (ogTagTitle == "image" && !ogTagValue.startsWith("http")) {
            data[ogTagTitle] = "http://" + _extractHost(url) + ogTagValue;
          } else {
            data[ogTagTitle] = ogTagValue;
          }
        }
      });
      _scrapeDataToEmptyValue(data, document, url);
    }
    return data;
  }

  static String _extractHost(String link) {
    Uri uri = Uri.parse(link);
    return uri.host;
  }

  static void _scrapeDataToEmptyValue(Map data, Document document, String url) {
    if (!data.containsKey("title") ||
        data["title"] == null ||
        data["title"] == "") {
      data["title"] = _scrapeTitle(document);
    }

    if (!data.containsKey("image") ||
        data["image"] == null ||
        data["image"] == "") {
      data["image"] = _scrapeImage(document, url);
    }

    if (!data.containsKey("description") ||
        data["description"] == null ||
        data["description"] == "") {}
    data["description"] = _scrapeDescription(document);
  }

  static String _scrapeTitle(Document document) {
    var tagTitle = document.head.getElementsByTagName("title")[0].text;
    if (tagTitle != null) {
      return tagTitle;
    }
    return "";
  }

  static String _scrapeDescription(Document document) {
    var meta = document.getElementsByTagName("meta");
    var description = "";
    var metaDescription = meta.firstWhere(
        (e) => e.attributes["name"] == "description",
        orElse: () => null);

    if (metaDescription != null) {
      description = metaDescription.attributes["content"];
    }

    if (description != null && description != "") {
      return description;
    } else {
      description = document.head.getElementsByTagName("title")[0].text;
    }
    return description;
  }

  static String _scrapeImage(Document document, String url) {
    var images = document.body.getElementsByTagName("img");
    var imageSrc = "";
    if (images.length > 0) {
      imageSrc = images[0].attributes["src"];

      if (!imageSrc.startsWith("http")) {
        imageSrc = "http://" + _extractHost(url) + imageSrc;
      }
    }
    if (imageSrc == "") {
      print("WARNING - WebPageParser - " + url);
      print(
          "WARNING - WebPageParser - image might be empty. Tag <img> was not found.");
    }
    return imageSrc;
  }

  static List<Element> _getOgPropertyData(Document document) {
    return document.head.querySelectorAll("[property*='og:']");
  }

  static String _addWWWPrefixIfNotExists(String uri) {
    if (uri == null || uri == "") {
      return uri;
    }

    Uri prefixUri;
    Uri parsedUri = Uri.parse(uri);
    if (!parsedUri.host.startsWith('www')) {
      prefixUri = parsedUri.replace(host: 'www.' + parsedUri.host);
    }
    return prefixUri.toString();
  }
}
