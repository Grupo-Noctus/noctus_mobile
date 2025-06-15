import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

void showSnackBar(
  String msg, {
  Duration duration = const Duration(seconds: 7),
  void Function()? onListen,
}) {
  final BuildContext context = getIt<IAppService>().context!;
  final SnackBar snackBar = SnackBar(
    duration: duration,
    backgroundColor: ThemeHelper.kDarkBlack,
    margin: const EdgeInsets.all(34),
    behavior: SnackBarBehavior.floating,
    content: Text(
      msg,
      style: const TextStyle(
        color: ThemeHelper.kAccentGreen,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  try {
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      onListen?.call();
    });
  } catch (_) {}
}