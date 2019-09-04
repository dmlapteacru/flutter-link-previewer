## [1.0.5]
### Width and Height now depends on parent size
### Font sizes pretty much auto resizable
### Image is auto resizable

## [1.1.0]
### Added default placeholder - if data is not loaded there is a placeholder (grey container).
### There is option to add a custom placeholder: Ex: LinkPreviewer(placeholder: Container())
### Link now is trimming - trim()
### Resolved bug with images where http..(host) was always added to image uri
### Added new properties: 
### 1. showTitle - false or true (default) - allows to hide title
### 2. showBody - false or true (default) - allows to hide body

## [1.2.0]
### Handling https certificates failure (replacing https to http)
### Adding 'www' to image uri, if not exists
### Changed body maxLines multiplier for vertical direction (maxLines = layoutHeight / 20.5)
### Changed body maxLines multiplier for horizontal direction (maxLines = layoutHeight / 60)
### Added new property - bodyTextOverflow
### Added new property - bodyMaxLines
### Changed parsing way - not it parses the web page from string (was bytes - got parsing format errors from some web pages)

## [1.2.1]
### Resolved bug with adding WWW to image uri. Now it will be added only if original uri will return exception
### Removed multiplier for horizontal direction. Now if height less than 40 maxLines = 1, if it is greater then maxLines will increase by 1 for each 15 px
