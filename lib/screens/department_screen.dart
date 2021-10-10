import 'package:flutter/material.dart';
import 'package:synced_admin_portal/data/data_provider.dart';
import 'package:synced_admin_portal/data/gl_queries.dart';
import 'package:synced_admin_portal/entities/department.dart';
import 'package:synced_admin_portal/enums/loading_enum.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({Key? key}) : super(key: key);

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  List<Department> departments = [];
  late DepartmentDataSource departmentDataSource;
  LoadingState loadingState = LoadingState.loading;
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _yearsController = TextEditingController();
  TextEditingController _otherInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDepartments();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _departmentController,
                          decoration: getTextFieldDecoration('Department name'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _yearsController,
                          decoration: getTextFieldDecoration('Years'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _otherInfoController,
                          decoration:
                              getTextFieldDecoration('Other Information'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          child: Text('Add'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: () {
              switch (loadingState) {
                case LoadingState.loading:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case LoadingState.loadingCompleted:
                  return Container(
                    child: Center(
                      child: SfDataGrid(
                        columns: [
                          GridColumn(
                              columnName: 's.no',
                              label: Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'S.NO',
                                  ))),
                          GridColumn(
                              columnName: 'name',
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Name'))),
                          GridColumn(
                              columnName: 'years',
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Years',
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                          GridColumn(
                              columnName: 'other_info',
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Other Information'))),
                        ],
                        source: departmentDataSource,
                      ),
                    ),
                  );
                case LoadingState.loadingError:
                  return Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text('Something went wrong'),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                                onPressed: () {
                                  getDepartments();
                                },
                                child: Text('Retry')),
                          ),
                        ],
                      ),
                    ),
                  );
              }
            }(),
          ),
        ],
      ),
    );
  }

  getTextFieldDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(),
      //hintText: hint,
      labelText: hint,
    );
  }

  getDepartments() async {
    List<Department> departments = [];
    List<dynamic> departmentsData;
    final data = await DataProvider().getQueryResult(getAllDepartments);
    departmentsData = data.data['communion_department'];
    try {
      setState(() {
        loadingState = LoadingState.loading;
      });
      departmentsData.forEach((department) {
        String id = department['id'];
        String name = department['name'];
        String years = department['years'];
        String other_infos = department['other_infos'];
        departments.add(Department(id, name, years, other_infos));
      });
      setState(() {
        departmentDataSource =
            DepartmentDataSource(departmentData: departments);
        loadingState = LoadingState.loadingCompleted;
      });
    } catch (e) {
      setState(() {
        loadingState = LoadingState.loadingError;
      });
    }
  }
}

class DepartmentDataSource extends DataGridSource {
  List<DataGridRow> _departmentData = [];

  List<DataGridRow> get departmentData => _departmentData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  DepartmentDataSource({required List<Department> departmentData}) {
    _departmentData = departmentData.asMap().entries.map((e) {
      int idx = e.key;
      Department val = e.value;
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 's.no', value: idx),
        DataGridCell<String>(columnName: 'name', value: val.name),
        DataGridCell<String>(columnName: 'years', value: val.years),
        DataGridCell<String>(columnName: 'other_info', value: val.otherInfos),
      ]);
    }).toList();
  }
}
