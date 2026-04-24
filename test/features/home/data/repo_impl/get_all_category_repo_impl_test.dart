// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tradehub/core/api/api_result/api_result.dart';
// import 'package:tradehub/core/utils/network/network_info.dart';
// import 'package:tradehub/features/main_layout/home/data/data_source/get_all_category_data_source.dart';
// import 'package:tradehub/features/main_layout/home/data/data_source/home_local_data_source.dart';
// import 'package:tradehub/features/main_layout/home/data/models/responses/get_all_category_response.dart';
// import 'package:tradehub/features/main_layout/home/data/repo_impl/get_all_category_repo_impl.dart';
// import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';

// import 'get_all_category_repo_impl_test.mocks.dart';

// class ListOfGetAllCategoryResponseMatcher extends Matcher {
//   final List<GetAllCategoryResponse> expected;
//   ListOfGetAllCategoryResponseMatcher(this.expected);
//   @override
//   bool matches(item, Map matchState) => item is List<GetAllCategoryResponse>;
//   @override
//   Description describe(Description description) =>
//       description.add('List<GetAllCategoryResponse>');
// }

// @GenerateMocks([GetAllCategoryDataSource, HomeLocalDataSource, NetworkInfo])
// void main() {
//   late GetAllCategoryRepoImpl repository;
//   late MockGetAllCategoryDataSource mockRemoteDataSource;
//   late MockHomeLocalDataSource mockLocalDataSource;
//   late MockNetworkInfo mockNetworkInfo;
//   provideDummy<ApiResult<List<GetAllCategoryResponse>>>(
//     Success(data: []),
//   );
//   setUp(() {
//     mockRemoteDataSource = MockGetAllCategoryDataSource();
//     mockLocalDataSource = MockHomeLocalDataSource();
//     mockNetworkInfo = MockNetworkInfo();
//     repository = GetAllCategoryRepoImpl(
//       mockRemoteDataSource,
//       mockLocalDataSource,
//       mockNetworkInfo,
//     );
//   });

//   group('GetAllCategoryRepoImpl', () {
//     final tResponse = [const GetAllCategoryResponse(id: 1, name: 'Food')];

//     test('should fetch remote categories and cache them when online', () async {
//       // Arrange
//       when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//       when(mockRemoteDataSource.getCategory())
//           .thenAnswer((_) async => Success(data: tResponse));
//       when(mockLocalDataSource.cacheCategories(any))
//           .thenAnswer((_) async => {});

//       // Act
//       final result = await repository.getCategory();

//       // Assert
//       expect(result, isA<Success<List<GetCategoryEntity>>>());
//       verify(mockRemoteDataSource.getCategory()).called(1);
//       verify(mockLocalDataSource.cacheCategories(tResponse)).called(1);
//     });

//     test('should return cached categories when offline', () async {
//       // Arrange
//       when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//       when(mockLocalDataSource.getCachedCategories())
//           .thenAnswer((_) async => tResponse);

//       // Act
//       final result = await repository.getCategory();

//       // Assert
//       expect(result, isA<Success<List<GetCategoryEntity>>>());
//       verify(mockLocalDataSource.getCachedCategories()).called(1);
//       verifyZeroInteractions(mockRemoteDataSource);
//     });

//     test('should return Error when offline and no cache exists', () async {
//       // Arrange
//       when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//       when(mockLocalDataSource.getCachedCategories())
//           .thenAnswer((_) async => null);

//       // Act
//       final result = await repository.getCategory();

//       // Assert
//       expect(result, isA<Error<List<GetCategoryEntity>>>());
//     });
//   });
// }
