enum Status { initial, loading, success, error, connected, disconnected }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isConnected => this == Status.connected;
  bool get isDisconnected => this == Status.disconnected;
}