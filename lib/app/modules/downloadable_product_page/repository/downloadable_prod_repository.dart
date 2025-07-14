import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/downloadable_prod_api.dart';

class DownloadableProdRepository {
  final DownloadableProdApi _api = DownloadableProdApi();

  Future<SuccessOrError> fetchDownloadableProducts() =>
      _api.fetchDownloadableProducts();

  Future<SuccessOrError> fetchUserAgreementText(String guid) =>
      _api.fetchUserAgreementText(guid);

  Future<SuccessOrError> downloadFile(String guid, String consent) =>
      _api.downloadFile(guid, consent);
}
