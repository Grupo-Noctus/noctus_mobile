import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/assets_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/ui/redirect/view_models/splash_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/redirect/view_models/splash_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashViewmodel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashFactoryViewModel().create(context);
    _viewModel.init();
  }

  @override
  void dispose() {
    SplashFactoryViewModel().dispose(context, _viewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsHelper.assetsM,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            const Text(
              'Carregando...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
