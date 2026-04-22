// import 'dart:async';
// import 'package:injectable/injectable.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
//   Stream<bool> get onConnectivityChanged;
// }

// @Injectable(as: NetworkInfo)
// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnection _internetConnection;

//   NetworkInfoImpl(this._internetConnection);

//   @override
//   Future<bool> get isConnected async {
//     return await _internetConnection.hasInternetAccess;
//   }

//   @override
//   Stream<bool> get onConnectivityChanged {
//     return _internetConnection.onStatusChange.map(
//       (status) => status == InternetStatus.connected,
//     );
//   }
// }

// @module
// abstract class NetworkModule {
//   @lazySingleton
//   InternetConnection get internetConnection => InternetConnection();
// }
