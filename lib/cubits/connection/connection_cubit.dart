import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';

import 'connection_event.dart';
import 'connection_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  bool _isManuallyDisconnected = false;

  InternetBloc() : super(InternetInitial()) {
    // عند الضغط على زر "Check Connection"
    on<InternetChecked>((event, emit) async {
      if (_isManuallyDisconnected) {
        emit(InternetDisconnectedState());
      } else {
        final isConnected = await _checkInternet();
        emit(isConnected
            ? InternetConnectedState()
            : InternetDisconnectedState());
      }
    });

    // توصيل أو فصل يدوي
    on<InternetManuallyDisconnected>((event, emit) {
      _isManuallyDisconnected = !_isManuallyDisconnected;
      emit(_isManuallyDisconnected
          ? InternetDisconnectedState()
          : InternetConnectedState());
    });

    // أحداث مباشرة
    on<InternetConnected>((event, emit) => emit(InternetConnectedState()));
    on<InternetDisconnected>(
        (event, emit) => emit(InternetDisconnectedState()));
  }

  // فحص الاتصال الحقيقي بالإنترنت
  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
