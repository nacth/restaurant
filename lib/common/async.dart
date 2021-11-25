import 'package:flutter/material.dart';
import 'package:restaurant/core/exception/api_exception.dart';

enum AsyncStatus { Uninitialized, Loading, Fail, Success }

class Async<T> {
  T? data;
  ApiException? error;
  final ValueNotifier<AsyncStatus> state;

  Async(this.data, this.error, this.state);

  Async.initial()
      : data = null,
        error = null,
        state = ValueNotifier(AsyncStatus.Uninitialized);

  Async loading() {
    this.state.value = AsyncStatus.Loading;
    return this;
  }

  Async fail(ApiException error) {
    this.state.value = AsyncStatus.Fail;
    this.error = error;
    return this;
  }

  Async success(T data) {
    this.state.value = AsyncStatus.Success;
    this.data = data;
    return this;
  }

  bool hasData() => this.data != null;

  bool get isLoading => this.state.value == AsyncStatus.Loading;

  bool get isFail => this.state.value == AsyncStatus.Fail;

  bool get isSuccess => this.state.value == AsyncStatus.Success;

  bool get isUninitialized => this.state.value == AsyncStatus.Uninitialized;

  bool get isUninitializedOrLoading =>
      this.state.value == AsyncStatus.Loading ||
      this.state.value == AsyncStatus.Uninitialized;

  @override
  bool operator ==(Object other) {
    return other is Async && other.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}

Async<T> uninitialized<T>() {
  return Async<T>.initial();
}

isInitializeOrLoading(AsyncStatus status) {
  return status == AsyncStatus.Loading || status == AsyncStatus.Uninitialized;
}
