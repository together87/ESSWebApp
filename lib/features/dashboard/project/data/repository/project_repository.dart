import '/common_libraries.dart';

class ProjectRepository extends BaseRepository {
  ProjectRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/project');

  /// get project by id
  Future<Project> getProjectById(
    String projectId,
  ) async {
    Response response = await super.get('$url/$projectId');
    if (response.statusCode == 200) {
      return ProjectData.fromJson(response.body).data;
    }
    throw Exception();
  }

  Future<List<Project>> getFilteredProjectList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      final data = FilteredProjectData.fromJson(response.body).data;
      return data;
    }
    throw Exception();
  }

  Future<List<Document>> getDocumentListForDetail(String auditId) async {
    // Response response = await super.get('$url');
    //
    // if (response.statusCode == 200) {
    //   return List.from(json.decode(response.body)).map((e) => Document.fromMap(e)).toList();
    // }
    //
    // throw Exception();
    List<Document> documentList = List.empty(growable: true);
    documentList.add(
      const Document(
        shortDescription: "Snow removal guidelines",
        id: 1,
        fileName: "snow-plan.doc",
        upload: "Josh Peyton on 12/3/2020",
        uri: '',
      ),
    );
    documentList.add(
      const Document(
        shortDescription: "Monthly lab cleanse document",
        id: 2,
        fileName: "lab-cleaning-guideline.doc",
        upload: "Greg Hugh on 12/3/2019",
        uri: '',
      ),
    );
    documentList.add(
      const Document(
        shortDescription: "Guidelines on mixing concrete",
        id: 3,
        fileName: "concrete-mixing-guidelines.doc",
        upload: "Ryan Gravener on 1/19/2010",
        uri: '',
      ),
    );
    return documentList;
  }

  // add project
  Future<EntityResponse> addProject(ProjectCreate project) async {
    Response response = await super.post(
      url,
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit project
  Future<EntityResponse> editProject(ProjectCreate project) async {
    Response response = await super.put(
      url,
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteProject(String projectId) async {
    Response response = await super.delete('$url/$projectId');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }
}
