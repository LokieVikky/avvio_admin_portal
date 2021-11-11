import 'package:graphql/client.dart';
import 'package:http/io_client.dart';
import 'package:synced_admin_portal/entities/areas_of_interest.dart';
import 'package:synced_admin_portal/entities/college.dart';
import 'package:synced_admin_portal/entities/course.dart';
import 'package:synced_admin_portal/entities/course_areas_of_interest.dart';
import 'package:synced_admin_portal/entities/course_media.dart';
import 'package:synced_admin_portal/entities/department.dart';
import 'package:synced_admin_portal/entities/media.dart';
import 'package:synced_admin_portal/entities/premium_colleges.dart';
import 'package:synced_admin_portal/entities/user_areas_of_interest.dart';
import 'package:synced_admin_portal/entities/users_type.dart';

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

  getCommunionAreasOfInterest() async {
    List<AreasOfInterest> communionAreasOfInterest = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllCommunionAreasOfInterest);
    areasOfInterest = data.data['communion_areas_of_interest'];
    try {
      areasOfInterest.forEach((communion_areas_of_interest) {
        String id = communion_areas_of_interest['id'];
        String name = communion_areas_of_interest['name'];
        communionAreasOfInterest.add(AreasOfInterest(id, name));
      });
      print(areasOfInterest.toString());
      return communionAreasOfInterest;
    } catch (e) {
      rethrow;
    }
  }

  addCommunionAreasOfInterest(AreasOfInterest communionAreasOfInterest) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(insertCommunionAreasOfInterest),
          variables: {
            'name': communionAreasOfInterest.name,
          });
      final QueryResult data = await _getMutationResult(
          insertCommunionAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateCommunionAreasOfInterest(
      AreasOfInterest communionAreasOfInterest) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateAreasOfInterest), variables: {
        '_eq': communionAreasOfInterest.id,
        'name': communionAreasOfInterest.name,
      });
      final QueryResult data = await _getMutationResult(updateAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteCommunionAreasOfInterest(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteAreasOfInterest), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(deleteAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //communion_college
  allCommunionCollege() async {
    List<College> communionCollege = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllCommunionCollege);
    areasOfInterest = data.data['communion_college'];
    try {
      areasOfInterest.forEach((communionCollege) {
        String contactPerson = communionCollege['contact_person'];
        String contactPersonPhone = communionCollege['contact_person_phone'];
        String id = communionCollege['id'];
        String location = communionCollege['location'];
        String name = communionCollege['name'];
        String phone = communionCollege['phone'];
        communionCollege.add(College(
            contactPerson, contactPersonPhone, id, location, name, phone));
      });
      print(areasOfInterest.toString());
      return communionCollege;
    } catch (e) {
      rethrow;
    }
  }

  addCommunionCollege(College communionCollege) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertCommunionCollege), variables: {
        'contact_person': communionCollege.contactPerson,
        'contact_person_phone': communionCollege.contactPersonPhone,
        'location': communionCollege.location,
        'name': communionCollege.name,
        'phone': communionCollege.phone,
      });
      final QueryResult data = await _getMutationResult(insertCommunionCollege,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateCommunionCollegeValue(College communionCollege) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateCommunionCollege), variables: {
        '_eq': communionCollege.id,
        'contact_person': communionCollege.contactPerson,
        'contact_person_phone': communionCollege.contactPersonPhone,
        'location': communionCollege.location,
        'name': communionCollege.name,
        'phone': communionCollege.phone,
      });
      final QueryResult data = await _getMutationResult(updateCommunionCollege,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteCommunionCollegeValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteCommunionCollege), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(deleteCommunionCollege,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //communion_course_areas_of_interest
  allCommunionCourseAreasOfInterest() async {
    List<CourseAreasOfInterest> communionCourseAreasOfInterest = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllCommunionCourseAreasOfInterest);
    areasOfInterest = data.data['communion_course_areas_of_interest'];
    try {
      areasOfInterest.forEach((communionCourseAreasOfInterest) {
        String id = communionCourseAreasOfInterest['id'];
        String areasOfInterestId =
            communionCourseAreasOfInterest['areas_of_interest_id'];
        String courseId = communionCourseAreasOfInterest['course_id'];
        communionCourseAreasOfInterest
            .add(CourseAreasOfInterest(id, areasOfInterestId, courseId));
      });
      print(areasOfInterest.toString());
      return communionCourseAreasOfInterest;
    } catch (e) {
      rethrow;
    }
  }

  addCommunionCourseAreasOfInterest(
      CourseAreasOfInterest communionCourseAreasOfInterest) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(insertCommunionCourseAreasOfInterest),
          variables: {
            'areas_of_interest_id':
                communionCourseAreasOfInterest.areasOfInterestId,
            'course_id': communionCourseAreasOfInterest.courseId,
          });
      final QueryResult data = await _getMutationResult(
          insertCommunionCourseAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateCommunionCourseAreasOfInterestValue(
      CourseAreasOfInterest communionCourseAreasOfInterest) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(updateCommunionCourseAreasOfInterest),
          variables: {
            '_eq': communionCourseAreasOfInterest.id,
            'areas_of_interest_id':
                communionCourseAreasOfInterest.areasOfInterestId,
            'course_id': communionCourseAreasOfInterest.courseId,
          });
      final QueryResult data = await _getMutationResult(
          updateCommunionCourseAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteCommunionCourseAreasOfInterestValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteCommunionCollege), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(
          deleteCommunionCourseAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //course_media
  allCourseMedia() async {
    List<CourseMedia> courseMedia = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllCourseMedia);
    areasOfInterest = data.data['communion_course_media'];
    try {
      areasOfInterest.forEach((courseMedia) {
        String id = courseMedia['id'];
        String areasOfInterestId = courseMedia['course_id'];
        String courseId = courseMedia['media_id'];
        courseMedia.add(CourseMedia(id, areasOfInterestId, courseId));
      });
      print(areasOfInterest.toString());
      return courseMedia;
    } catch (e) {
      rethrow;
    }
  }

  addCourseMedia(CourseMedia courseMedia) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertCourseMedia), variables: {
        'course_id': courseMedia.courseId,
        'media_id': courseMedia.mediaId,
      });
      final QueryResult data =
          await _getMutationResult(insertCourseMedia, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateCourseMediaValue(CourseMedia courseMedia) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateCourseMedia), variables: {
        '_eq': courseMedia.id,
        'course_id': courseMedia.courseId,
        'media_id': courseMedia.mediaId,
      });
      final QueryResult data =
          await _getMutationResult(updateCourseMedia, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteCourseMediaValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteCourseMedia), variables: {'_eq': id});
      final QueryResult data =
          await _getMutationResult(deleteCourseMedia, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //course
  allCourse() async {
    List<Course> course = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllCourses);
    areasOfInterest = data.data['communion_courses'];
    try {
      areasOfInterest.forEach((course) {
        String id = course['id'];
        String courseAreasOfInterestId = course['course_areas_of_interest_id'];
        String courseId = course['course_id'];
        String courseMediaId = course['course_media_id'];
        String createdBy = course['created_by'];
        String createdDate = course['created_date'];
        String description = course['description'];
        String name = course['name'];
        String thumbnailUrl = course['thumbnail_url'];

        course.add(Course(id, courseAreasOfInterestId, courseId, courseMediaId,
            createdBy, createdDate, description, name, thumbnailUrl));
      });
      print(areasOfInterest.toString());
      return course;
    } catch (e) {
      rethrow;
    }
  }

  addCourse(Course course) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertCourses), variables: {
        'course_areas_of_interest_id': course.courseAreasOfInterestId,
        'course_id': course.courseId,
        'course_media_id': course.courseMediaId,
        'created_by': course.createdBy,
        'course_id': course.courseId,
        'description': course.description,
        'name': course.name,
        'thumbnail_url': course.thumbnailUrl,
      });
      final QueryResult data =
          await _getMutationResult(insertCourses, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateCourseValue(Course course) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateCourses), variables: {
        '_eq': course.id,
        'course_areas_of_interest_id': course.courseAreasOfInterestId,
        'course_id': course.courseId,
        'course_media_id': course.courseMediaId,
        'created_by': course.createdBy,
        'created_date': course.createdDate,
        'description': course.description,
        'name': course.name,
        'thumbnail_url': course.thumbnailUrl,
      });
      final QueryResult data =
          await _getMutationResult(updateCourses, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteCourseValue(String id) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(deleteCourses), variables: {'_eq': id});
      final QueryResult data =
          await _getMutationResult(deleteCourses, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //media

  allMedia() async {
    List<Media> media = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllMedia);
    areasOfInterest = data.data['communion_media'];
    try {
      areasOfInterest.forEach((course) {
        String id = course['id'];
        String type = course['type'];
        String url = course['url'];
        course.add(Media(id, type, url));
      });
      print(areasOfInterest.toString());
      return media;
    } catch (e) {
      rethrow;
    }
  }

  addMedia(Media media) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertMedia), variables: {
        'type': media.type,
        'url': media.url,
      });
      final QueryResult data =
          await _getMutationResult(insertMedia, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateMediaValue(Media media) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateCourses), variables: {
        'id': media.id,
        'type': media.type,
        'url': media.url,
      });
      final QueryResult data =
          await _getMutationResult(updateCourses, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteMediaValue(String id) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(deleteMedia), variables: {'_eq': id});
      final QueryResult data =
          await _getMutationResult(deleteMedia, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //premiumColleges

  allPremiumColleges() async {
    List<PremiumColleges> premiumColleges = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllPremiumColleges);
    areasOfInterest = data.data['communion_premium_colleges'];
    try {
      areasOfInterest.forEach((premiumColleges) {
        String id = premiumColleges['id'];
        String collegeId = premiumColleges['college_id'];
        premiumColleges.add(PremiumColleges(id, collegeId));
      });
      print(areasOfInterest.toString());
      return premiumColleges;
    } catch (e) {
      rethrow;
    }
  }

  addPremiumColleges(PremiumColleges premiumColleges) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertPremiumColleges), variables: {
        'college_id': premiumColleges.collegeId,
      });
      final QueryResult data = await _getMutationResult(insertPremiumColleges,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updatePremiumCollegesValue(PremiumColleges premiumColleges) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updatePremiumColleges), variables: {
        'id': premiumColleges.id,
        'college_id': premiumColleges.collegeId,
      });
      final QueryResult data = await _getMutationResult(updatePremiumColleges,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deletePremiumCollegesValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deletePremiumColleges), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(deletePremiumColleges,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //users_areas_of_interest

  allUsersAreasOfInterest() async {
    List<UserAreasOfInterest> userAreasOfInterest = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getAllUsersAreasOfInterest);
    areasOfInterest = data.data['communion_course_areas_of_interest'];
    try {
      areasOfInterest.forEach((userAreasOfInterest) {
        String id = userAreasOfInterest['id'];
        String areasOfInterestId = userAreasOfInterest['areas_of_interest_id'];
        String courseId = userAreasOfInterest['course_id'];
        userAreasOfInterest
            .add(UserAreasOfInterest(id, areasOfInterestId, courseId));
      });
      print(areasOfInterest.toString());
      return userAreasOfInterest;
    } catch (e) {
      rethrow;
    }
  }

  addUsersAreasOfInterest(UserAreasOfInterest userAreasOfInterest) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(insertAllUsersAreasOfInterests),
          variables: {
            'areas_of_interest_id': userAreasOfInterest.areasOfInterestId,
            'course_id': userAreasOfInterest.courseId,
          });
      final QueryResult data = await _getMutationResult(
          insertAllUsersAreasOfInterests,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateUsersAreasOfInterestValue(
      UserAreasOfInterest userAreasOfInterest) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(updateAllUsersAreasOfInterest),
          variables: {
            'id': userAreasOfInterest.id,
            'areas_of_interest_id': userAreasOfInterest.areasOfInterestId,
            'course_id': userAreasOfInterest.courseId,
          });
      final QueryResult data = await _getMutationResult(
          updateAllUsersAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteUsersAreasOfInterestValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteAllUsersAreasOfInterest), variables: {'_eq': id});
      final QueryResult data = await _getMutationResult(
          deleteAllUsersAreasOfInterest,
          mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  //users_types
  getUsersTypes() async {
    List<UserType> userType = [];
    List<dynamic> areasOfInterest;
    final data = await _getQueryResult(getUsersTypes());
    areasOfInterest = data.data['communion_users_types'];
    try {
      areasOfInterest.forEach((userType) {
        String id = userType['id'];
        String user = userType['user_type'];
        userType.add(UserType(id, user));
      });
      print(areasOfInterest.toString());
      return userType;
    } catch (e) {
      rethrow;
    }
  }

  addUsersTypes(UserType userType) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(insertUsersTypes), variables: {
        'user_type': userType.userType,
      });
      final QueryResult data =
          await _getMutationResult(insertUsersTypes, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  updateUsersTypesValue(UserType userType) async {
    try {
      MutationOptions options =
          MutationOptions(document: gql(updateUsersTypes), variables: {
        '_eq': userType.id,
        'user_type': userType.userType,
      });
      final QueryResult data =
          await _getMutationResult(updateUsersTypes, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }

  deleteUsersTypesValue(String id) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(deleteUsersTypes), variables: {'_eq': id});
      final QueryResult data =
          await _getMutationResult(deleteUsersTypes, mutationOptions: options);
      return data.hasException;
    } catch (e) {
      rethrow;
    }
  }
}
