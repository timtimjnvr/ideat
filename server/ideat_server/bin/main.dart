import 'package:ideat_server/ideat_server.dart';

Future main() async {
  final app = Application<IdeatServerChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8889;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
