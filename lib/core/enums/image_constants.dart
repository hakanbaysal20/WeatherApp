


enum ImageConstants{
  humidity('im_humidity2');
  final String value;
  const ImageConstants(this.value);
  String get toPng => 'asset/image/$value.png';

}