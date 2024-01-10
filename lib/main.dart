import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_api_todo_project/core/model/shared_preferenses_instances.dart';
import 'package:my_api_todo_project/provider/thema_mode_provider.dart';
Future<void> main() async{
  await SharedPreferencesInstance.initialize();
  runApp(const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ref.watch(themeModeProvider),
      home: const Home(),
    );
  }
}

ThemeData _buildTheme(Brightness brightness){
  return ThemeData(
    useMaterial3: true,
    brightness:brightness,
  );
}