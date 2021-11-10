import 'package:graphql/client.dart';
import 'package:http/io_client.dart';
import 'package:synced_admin_portal/entities/department.dart';

import 'gl_queries.dart';

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

  _getQueryResult(String query, {QueryOptions? queryOptions}) async {
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

  _getMutationResult(String query, {MutationOptions? mutationOptions}) async {
    try {
      MutationOptions options =
          mutationOptions ?? MutationOptions(document: gql(query));
      GraphQLClient client = _getGLClient();
      QueryResult result =
          await client.mutate(options).timeout(Duration(seconds: 10));
      if (result.hasException) {
        throw result.exception.toString();
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  getDepartments() async {
    List<Department> departments = [];
    List<dynamic> departmentsData;
    final data = await _getQueryResult(getAllDepartmentsQuery);
    departmentsData = data.data['communion_department'];
    try {
      departmentsData.forEach((department) {
        String id = department['id'];
        String name = department['name'];
        String years = department['years'];
        String other_infos = department['other_infos'];
        departments.add(Department(id, name, years, other_infos));
      });
      return departments;
    } catch (e) {
      rethrow;
    }
  }

  addDepartment(Department department) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertDepartmentQuery), variables: {
        'name': department.name,
        'other_infos': department.otherInfos,
        'years': department.years
      });
      final QueryResult data = await _getMutationResult(insertDepartmentQuery,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateDepartment(Department department) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateDepartmentQuery), variables: {
        '_eq': department.id,
        'name': department.name,
        'other_infos': department.otherInfos,
        'years': department.years
      });
      final QueryResult data = await _getMutationResult(updateDepartmentQuery,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteDepartment(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteDepartmentQuery), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(deleteDepartmentQuery,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }
}
