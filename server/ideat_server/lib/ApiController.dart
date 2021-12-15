import 'package:ideat_server/ideat_server.dart';

class ApiController extends ResourceController {
  @Operation.get('name')
  Future<Response> getRestMethod() async {
    final methodName = request != null ? request!.path.variables['name'] : "";
    switch (methodName) {
      case "test": {
        return Response.ok("This is a test");
      }
      default: {
        return Response.badRequest(body: {"error": "no method"});
      }
    }
  }
}
