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
      var document = parser.parse(utf8.decode(response.bodyBytes));
      var openGraphMetaTags = _getOgPropertyData(document);

      openGraphMetaTags.forEach((element) {
        var ogTagTitle = element.attributes['property'].split("og:")[1];
        var ogTagValue = element.attributes['content'];

        if ((ogTagValue != null && ogTagValue != "") ||
            requiredAttributes.contains(ogTagTitle)) {
          if (ogTagValue == null || ogTagValue.length == 0) {
            ogTagValue = _scrapeDataToEmptyValue(ogTagTitle, document);
          }
          if (ogTagTitle == "image" &&
              (!ogTagValue.startsWith("http") ||
                  !ogTagValue.startsWith("https"))) {
            data[ogTagTitle] = "http://" + _extractHost(url) + ogTagValue;
          } else {
            data[ogTagTitle] = ogTagValue;
          }
        }
      });
    }

    return data;
  }

  static String _extractHost(String link) {
    Uri uri = Uri.parse(link);
    return uri.host;
  }

  static String _scrapeDataToEmptyValue(String tagTitle, Document document) {
    if (tagTitle == "title") {
      return document.head.getElementsByTagName("title")[0].text;
    }

    if (tagTitle == "image") {
      var images = document.body.getElementsByTagName("img");

      if (images.length > 0) {
        return images[0].attributes["src"];
      }

      return "";
    }

    return "";
  }

  static List<Element> _getOgPropertyData(Document document) {
    return document.head.querySelectorAll("[property*='og:']");
  }
}
