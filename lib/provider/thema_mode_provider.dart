import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/model/shared_preferenses_instances.dart';
final themeModeProvider=StateNotifierProvider<ThemeModeNotifier,ThemeMode>((ref) => ThemeModeNotifier());
class ThemeModeNotifier extends StateNotifier<ThemeMode>{
  static const String keyThemeMode ='theme_mode';
  final _pref=SharedPreferencesInstance().pref;
  ThemeModeNotifier():super(ThemeMode.system){
    //https://zenn.dev/tsukatsuka1783/articles/flutter_constract_super#%E8%A6%AA%E3%82%AF%E3%83%A9%E3%82%B9%E3%82%92%E7%B6%99%E6%89%BF%E3%81%99%E3%82%8B%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%AE%E5%A0%B4%E5%90%88
    state = _loadThemeMode()??ThemeMode.system;
  }
  Future<void>toggle()async{
    ThemeMode themeMode;
    switch(state){
      case ThemeMode.light:
        themeMode=ThemeMode.light;
        break;
      case ThemeMode.dark:
        themeMode=ThemeMode.dark;
        break;
      case ThemeMode.system:
        themeMode=ThemeMode.system;
        break;
    }
    await _saveThemeMode(themeMode).then((value){
      if(value==true){
        state=themeMode;
      }
    });
  }
  ThemeMode? _loadThemeMode(){
    final loaded=_pref.getString(keyThemeMode);
    if(loaded==null){
      return null;
    }
    //https://api.flutter.dev/flutter/material/ThemeMode.html
    return ThemeMode.values.byName(loaded);
  }
  Future<bool>_saveThemeMode(ThemeMode thememode)=>_pref.setString(keyThemeMode, thememode.name);
}


