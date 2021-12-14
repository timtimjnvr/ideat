import 'package:ideat_server/ideat_server.dart';
import 'package:liquidart_test/liquidart_test.dart';

export 'package:ideat_server/ideat_server.dart';
export 'package:liquidart_test/liquidart_test.dart';
export 'package:test/test.dart';
export 'package:liquidart/liquidart.dart';

/// A testing harness for ideat_server.
///
/// A harness for testing an liquidart application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<IdeatServerChannel> {
  @override
  Future onSetUp() async {}

  @override
  Future onTearDown() async {}
}
