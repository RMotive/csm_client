import 'dart:convert';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_client_testing/csm_client_testing.dart';

/// Handles utilities methods for [Client] testing purposes.
final class TestingClientUtils {
  /// Creates a [MockClient] instance object for {definition} purposes tests, overriding the actual [Client] that makes network request to the actual server.
  ///
  /// [endpointMocks] a [Map] object that stores the endpoint [String] identification and the overriden [T] object to force as a response inside a [SuccessFrame].
  static MockClient createMockClient<T extends IEncodable>(Map<String, T> endpointMocks) {
    final MockClient mockClient = MockClient(
      (Request request) async {
        final String endpointSegment = request.url.pathSegments.last;

        if (endpointMocks.containsKey(endpointSegment)) {
          T estela = endpointMocks[endpointSegment]!;
          DataMap dataMap = TestingFrameUtils.buildGenericFrame(
            estela.encode(),
          );

          return Response(jsonEncode(dataMap), 200);
        }

        return Response('', 404);
      },
    );

    return mockClient;
  }
}
