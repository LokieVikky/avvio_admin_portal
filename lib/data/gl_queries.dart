String getAllDepartmentsQuery = r'''
                      query getDepartments {
  communion_department {
    id
    name
    other_infos
    years
  }
}
''';

String insertDepartmentQuery = r'''
mutation insertDepartment($name: String = "", $other_infos: String = "", $years: String = "") {
  insert_communion_department(objects: {name: $name, other_infos: $other_infos, years: $years}) {
    returning {
      id
    }
  }
}
''';

String updateDepartmentQuery = r'''
mutation updateDepartment($name: String = "", $other_infos: String = "", $years: String = "", $_eq: uuid = "") {
  update_communion_department(where: {id: {_eq: $_eq}}, _set: {name: $name, other_infos: $other_infos, years: $years}) {
    returning {
      id
    }
  }
}
''';

String deleteDepartmentQuery = r'''
mutation deleteDepartment($_eq: uuid = "") {
  delete_communion_department(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';

String getAllCommunionAreasOfInterest = r''' query getCommunionAreasOfInterest {
  communion_areas_of_interest {
    id
    name
  }
} ''';

String insertCommunionAreasOfInterest = r'''
mutation insertCommunionAreasOfInterest($name: String = "") {
  insert_communion_areas_of_interest(objects: {name: $name}) {
    returning {
      id
    }
  }
}
''';

String updateAreasOfInterest = r'''
mutation updateAreasOfInterest($_eq: uuid = "",$name: String = "") {
  update_communion_areas_of_interest(where: {id: {_eq: $_eq}}, _set: {name: $name}) {
    returning {
      id
    }
  }
}
''';

String deleteAreasOfInterest = r'''
mutation deleteAreasOfInterest($_eq: uuid = "") {
  delete_communion_areas_of_interest(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';

//communion_college
String getAllCommunionCollege = r''' query getAllCommunionCollege {
  communion_college {
    contact_person
    contact_person_phone
    id
    location
    name
    phone
  }
} ''';

String insertCommunionCollege = r'''
mutation insertCommunionCollege($contact_person: String = "",$contact_person_phone:
                       String="",$location: String="",$name: String="",$phone: String="") {
  insert_communion_college(objects: {contact_person: $contact_person,contact_person_phone:$contact_person_phone,
                                     location:$location,name: $name,phone:$phone}) {
    returning {
      id
    }
  }
}
''';

String updateCommunionCollege = r'''
mutation updateCommunionCollege($_eq: uuid = "",$contact_person: String = "",$contact_person_phone:
                       String="",$location: String="",$name: String="",$phone: String="") {
  update_communion_college(where: {id: {_eq: $_eq}}, _set: {contact_person: $contact_person,contact_person_phone:$contact_person_phone,
                                     location:$location,name: $name,phone:$phone}) {
    returning {
      id
    }
  }
}
''';

String deleteCommunionCollege = r'''
mutation deleteCommunionCollege($_eq: uuid = "") {
  delete_communion_college(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';

//communion_course_areas_of_interest
String getAllCommunionCourseAreasOfInterest =
    r''' query getAllCommunionCourseAreasOfInterest {
  communion_course_areas_of_interest {
     areas_of_interest_id
     course_id
     id
  }
} ''';

String insertCommunionCourseAreasOfInterest = r'''
mutation insertCommunionCourseAreasOfInterest($areas_of_interest_id: uuid = "", $course_id: uuid = "") {
  insert_communion_course_areas_of_interest(objects: {areas_of_interest_id: $areas_of_interest_id,course_id:$course_id}) {
    returning {
      id
    }
  }
}
''';

String updateCommunionCourseAreasOfInterest = r'''
mutation updateCommunionCourseAreasOfInterest($_eq: uuid = "",$areas_of_interest_id: uuid = "", $course_id: uuid = "") {
  update_communion_course_areas_of_interest(where: {id: {_eq: $_eq}}, _set: {areas_of_interest_id: $areas_of_interest_id,course_id:$course_id}) {
    returning {
      id
    }
  }
}
''';

String deleteCommunionCourseAreasOfInterest = r'''
mutation deleteCommunionCourseAreasOfInterest($_eq: uuid = "") {
  delete_communion_course_areas_of_interest(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';

//course_media
String getAllCourseMedia = r''' query getAllCourseMedia {
  communion_course_media {
     course_id
     id
     media_id
  }
} ''';

String insertCourseMedia = r'''
mutation insertCourseMedia($course_id: uuid = "", $media_id: uuid = "") {
  insert_communion_course_media(objects: {course_id: $course_id,media_id:$media_id}) {
    returning {
      id
    }
  }
}
''';

String updateCourseMedia = r'''
mutation updateCourseMedia($_eq: uuid = "",$course_id: uuid = "", $media_id: uuid = "") {
  update_communion_course_media(where: {id: {_eq: $_eq}}, _set: {course_id: $course_id,media_id:$media_id}) {
    returning {
      id
    }
  }
}
''';

String deleteCourseMedia = r'''
mutation deleteCommunionCourseAreasOfInterest($_eq: uuid = "") {
  deletecommunion_course_media(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';

//courses
String getAllCourses = r''' query getAllCourses {
  communion_courses {
    course_areas_of_interest_id
    course_id
    course_media_id
    created_by
    created_date
    description
    id
    name
    thumbnail_url
  }
} ''';

String insertCourses = r'''
mutation insertCourses($course_areas_of_interest_id: String = "",$course_id:
                       String="",$course_media_id: String="",$created_by: String="",$created_date: String=""
                       $description: String="",$name: String="",$thumbnail_url: String="") {
  insert_communion_courses(objects: {course_areas_of_interest_id: $course_areas_of_interest_id,course_id:$course_id,
                                     course_media_id:$course_media_id,created_by: $created_by,created_date:$created_date,
                                     description:$description,name: $name,thumbnail_url:$thumbnail_url}) {
    returning {
      id
    }
  }
}
''';

String updateCourses = r'''
mutation updateCourses($_eq: uuid = "",$course_areas_of_interest_id: String = "",$course_id:
                       String="",$course_media_id: String="",$created_by: String="",$created_date: String=""
                       $description: String="",$name: String="",$thumbnail_url: String="") {
  update_communion_courses(where: {id: {_eq: $_eq}}, _set: {course_areas_of_interest_id: $course_areas_of_interest_id,course_id:$course_id,
                                     course_media_id:$course_media_id,created_by: $created_by,created_date:$created_date,
                                     description:$description,name: $name,thumbnail_url:$thumbnail_url}) {
    returning {
      id
    }
  }
}
''';

String deleteCourses = r'''
mutation deleteCourses($_eq: uuid = "") {
  delete_communion_courses(where: {id: {_eq: $_eq}}) {
    returning {
      id
    }
  }
}
''';
