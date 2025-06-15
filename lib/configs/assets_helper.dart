import 'package:noctus_mobile/core/library/extensions.dart';

const String _kAssetsDirectoryName = 'assets';

final class AssetsHelper {
  static final String _assetsAplication = [_kAssetsDirectoryName,  'aplication'].joinPath;

  static final String assetsM = [_assetsAplication, 'm_matera.png'].joinPath;
}