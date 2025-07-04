import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ID-id');

  var permission = Permission.locationWhenInUse;
  var status = await permission.status;

  if (status.isDenied) {
    await permission.request();
    // We haven't asked for permission yet or the permission has been denied before, but not permanently.
  }

  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }

  getIt.init();
}