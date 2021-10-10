import 'package:graphql/client.dart';
import 'package:http/io_client.dart';

class DataProvider {
  final String serverURL = 'http://18.191.43.67/v1/graphql';

  DataProvider._internal() {
/*    final HttpClient _httpClient = HttpClient();
    _httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    _ioClient = IOClient(_httpClient);*/
  }

  factory DataProvider() {
    return _dataProvider;
  }

  static final DataProvider _dataProvider = DataProvider._internal();

  late IOClient _ioClient;

  _getGLClient() {
    HttpLink _httpLink = HttpLink(
      serverURL,
    );
/*    AuthLink _authLink = AuthLink(
      getToken: () async => 'Bearer $accessToken',
    );*/
    Link _link = _httpLink;
    return GraphQLClient(link: _link, cache: GraphQLCache());
  }

  getQueryResult(String query, {QueryOptions? queryOptions}) async {
    try {
      QueryOptions options = queryOptions ?? QueryOptions(document: gql(query));
      GraphQLClient client = _getGLClient();
      QueryResult result =
          await client.query(options).timeout(Duration(seconds: 10));
      if (result.hasException) {
        throw result.exception.toString();
      }
      return result;
    } catch (e) {
      print(e);
    }
  }
}
