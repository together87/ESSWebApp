import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/dashboard/company/data/model/company_create.dart';
import 'package:ecosys_safety/features/dashboard/company/data/model/filtered_company_data.dart';

import '../model/company.dart';

class CompanyRepository extends BaseRepository {
  CompanyRepository({required super.token, required super.authBloc})
      : super(url: '/api/companies');

  /// get filtered companies list
  Future<List<Company>> getFilteredCompanyList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      final data = FilteredCompanyData.fromJson(response.body).data;
      return data;
    }
    throw Exception();
  }

  /// get company by id
  Future<Company> getCompanyById(String companyId) async {
    Response response = await super.get('$url/$companyId');

    if (response.statusCode == 200) {
      return CompanyData.fromJson(response.body).data;
    }
    throw Exception();
  }

  /// add company
  Future<EntityResponse> addCompany(CompanyCreate company) async {
    Response response = await super.post(url, body: company.toJson());

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// edit company
  Future<EntityResponse> editCompany(CompanyCreate company) async {
    Response response = await super.put(url, body: company.toJson());

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

  /// delete company by id
  Future<EntityResponse> deleteCompany(String companyId) async {
    Response response = await super.delete('$url/$companyId');

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
