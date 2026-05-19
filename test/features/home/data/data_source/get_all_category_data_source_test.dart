import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/data/api/home_api_client.dart';
import 'package:tradehub/features/main_layout/home/data/data_source/home_data_source.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_all_category_response.dart';

import 'get_all_category_data_source_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  late HomeDataSourceImpl dataSource;
  late MockHomeApiClient mockApiClient;

  setUp(() {
    provideDummy<List<GetAllCategoryResponse>>([]);

    mockApiClient = MockHomeApiClient();
    dataSource = HomeDataSourceImpl(mockApiClient);
  });

  group('GetAllCategoryDataSourceImpl', () {
    final tResponse = [const GetAllCategoryResponse(id: 1, name: 'Food', imageUrl: 'image_url')];

    test('should return Success with list of categories when API call succeeds',
        () async {
      // Arrange
      when(mockApiClient.getAllCategory()).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.getCategory();

      // Assert
      expect(result, isA<Success<List<GetAllCategoryResponse>>>());
      expect((result as Success).data, equals(tResponse));
      verify(mockApiClient.getAllCategory()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Error when API call throws an exception', () async {
      // Arrange
      when(mockApiClient.getAllCategory())
          .thenThrow(Exception('Network error'));

      // Act
      final result = await dataSource.getCategory();

      // Assert
      expect(result, isA<Error<List<GetAllCategoryResponse>>>());
      verify(mockApiClient.getAllCategory()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
