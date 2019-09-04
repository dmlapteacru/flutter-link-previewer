# link_previewer

A new Flutter package. Build container with image, title, description from web-site (link) will be provided.

## Getting Started

![alt text](https://github.com/dmlapteacru/flutter-link-previewer/blob/master/images/link_preview.PNG)

## Installing 
Use this package as a library
1. Depend on it

Add this to your package's pubspec.yaml file:


```yaml
dependencies:
  link_previewer: ^1.2.1
```

2. Install it

You can install packages from the command line:
with Flutter:

```
$ flutter pub get
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

3. Import it

Now in your Dart code, you can use:

```dart
import 'package:link_previewer/link_previewer.dart';
```

## Usage

```dart
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
```

## Properties (Constructor props)
| PropName      | Value         | Definition  |
| ------------- |:-------------:| -----:|
| `link`          | `String` value (Ex: `"http://..."`) | Link to website will be shown as LinkPreviewer |
| `titleFontSize`      | `double` (default: `15`, but it's auto resizable depends on layout(parent) width or hight)    |  Title font size  |
| `bodyFontSize` | `double` (default: `14`, but it's auto resizable depends on layout(parent) width or hight)   |    Body font size |
| `backgroundColor` | `Color` (default: `Colors.white`) | Background color in case there will be not much text and will be whitespace |
| `borderColor` | `Color` (default: `Colors.deepOrangeAccent`) | Border color of the previewer |
| `borderRadius` | `double` (default: `3.0`) | Border radius |
| `direction` | `ContentDirection` from the package (default: `ContentDirection.horizontal`)                                            Options: 1. `ContentDirection.horizontal` 2. `ContentDirection.vertical` | Content direction (image -> title -> body) |

#### From version 1.1.0
| PropName  | Value | Definition |
| --------- |:-----:| ----------:|
| `placeholder` | `Widget` | Custom placeholder while data is loading |
| `defaultPlaceholderColor` | `Color` (default: `light-grey`) | If placeholder is not set, will be used the default one and its color can be set using this prop (empty container with background) |
| `showTitle` | `bool` (default: `true`) | Title can be hiden using this prop, if it set to false |
| `showBody` | `bool` (default: `true`) | Body can be hiden using this prop, if it set to false |

#### From version 1.2.0
| PropName  | Value | Definition |
| --------- |:-----:| ----------:|
| `bodyTextOverflow` | `TextOverflow` (default: `TextOverflow.ellipsis` or `TextOverflow.fade`) | Text overflow prop |
| `bodyMaxLines` | `int` (default: `depends on hight`) | Max Lines that will be shown in the body |
