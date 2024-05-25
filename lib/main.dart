import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

enum PlatformType { Android, iOS, Linux, MacOS, Windows, Unknown }

class PlatformBloc extends Bloc<Object?, PlatformType> {
  PlatformBloc() : super(PlatformType.Unknown) {
    _detectPlatform();
  }

  void _detectPlatform() {
    PlatformType platformType;

    if (Platform.isAndroid) {
      platformType = PlatformType.Android;
    } else if (Platform.isIOS) {
      platformType = PlatformType.iOS;
    } else if (Platform.isLinux) {
      platformType = PlatformType.Linux;
    } else if (Platform.isMacOS) {
      platformType = PlatformType.MacOS;
    } else if (Platform.isWindows) {
      platformType = PlatformType.Windows;
    } else {
      platformType = PlatformType.Unknown;
    }

    add(platformType);
  }

  @override
  Stream<PlatformType> mapEventToState(Object? event) async* {
    if (event is PlatformType) {
      yield event;
    }
  }
}

class PlatformScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlatformBloc(),
      child: PlatformScreenContent(),
    );
  }
}

class PlatformScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformBloc, PlatformType>(
      builder: (context, platform) {
        ThemeData theme;
        if (platform == PlatformType.Windows) {
          theme = ThemeData.dark();
        } else {
          theme = ThemeData.light();
        }

        return MaterialApp(
          theme: theme,
          home: Scaffold(
            appBar: AppBar(
              title: Text('Экран платформы'),
            ),
            body: Center(
              child: Text(
                'Приложение запущено на: ${_platformName(platform)}',
              ),
            ),
          ),
        );
      },
    );
  }

  String _platformName(PlatformType platform) {
    switch (platform) {
      case PlatformType.Android:
        return 'Android';
      case PlatformType.iOS:
        return 'iOS';
      case PlatformType.Linux:
        return 'Linux';
      case PlatformType.MacOS:
        return 'macOS';
      case PlatformType.Windows:
        return 'Windows';
      default:
        return 'неизвестная платформа';
    }
  }
}

void main() {
  runApp(PlatformScreen());
}
