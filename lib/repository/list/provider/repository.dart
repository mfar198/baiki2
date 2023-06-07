import 'package:baiki2/model/list/model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ListModel> fetchListList() {
    return _provider.fetchListList();
  }
}

class NetworkError extends Error {}