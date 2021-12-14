import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /api/test returns 200 {This is a test}", () async {
    expectResponse(await harness.agent.get("/api/test"), 200,
        body: "This is a test");
  });
}
