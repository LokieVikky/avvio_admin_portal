String getAllDepartments = r'''
                      query getDepartments {
  communion_department {
    id
    name
    other_infos
    years
  }
}
''';

String insertDepartment = r'''
mutation insertDepartment($name: String = "", $other_infos: String = "", $years: String = "") {
  insert_communion_department(objects: {name: $name, other_infos: $other_infos, years: $years}) {
    returning {
      id
    }
  }
}
''';

String updateDepartment = r'''
mutation updateDepartment($name: String = "", $other_infos: String = "", $years: String = "", $_eq: uuid = "") {
  update_communion_department(where: {id: {_eq: $_eq}}, _set: {name: $name, other_infos: $other_infos, years: $years}) {
    returning {
      id
    }
  }
}
''';
