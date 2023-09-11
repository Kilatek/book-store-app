import 'package:book_store/core/util/log_utils.dart';
import 'package:rxdart/rxdart.dart';

extension StreamExt<T> on Stream<T> {
// ignore: prefer_named_parameters
  Stream<T> log(
    String name, {
    bool logOnListen = false,
    bool logOnData = false,
    bool logOnError = false,
    bool logOnDone = false,
    bool logOnCancel = false,
  }) {
    return doOnListen(() {
      if (logOnListen) {
        Log.d('▶️ onSubscribed', time: DateTime.now(), name: name);
      }
    }).doOnData((event) {
      if (logOnData) {
        Log.d('🟢 onEvent: $event', time: DateTime.now(), name: name);
      }
    }).doOnCancel(() {
      if (logOnCancel) {
        Log.d('🟡 onCanceled', time: DateTime.now(), name: name);
      }
    }).doOnError((e, _) {
      if (logOnError) {
        Log.e('🔴 onError $e', time: DateTime.now(), name: name);
      }
    }).doOnDone(() {
      if (logOnDone) {
        Log.d('☑️️ onCompleted', time: DateTime.now(), name: name);
      }
    });
  }
}
