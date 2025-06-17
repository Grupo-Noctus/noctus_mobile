import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/routing/route_generator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  Future<void> _onLogout(BuildContext context) async {
    final INonRelationalDataSource nonRelationalDataSource =
        NonRelationalFactoryDataSource().create();

    await nonRelationalDataSource.remove(DataBaseNoSqlSchemaHelper.kUserToken);

    RouteGeneratorHelper.onRouteInitialization(RouteGeneratorHelper.kRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _onLogout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Home!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

