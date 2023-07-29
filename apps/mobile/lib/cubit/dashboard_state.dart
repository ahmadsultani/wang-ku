part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final Dashboard dashboard;

  DashboardSuccess(this.dashboard);
}

class DashboardFailed extends DashboardState {
  final Failure failure;

  DashboardFailed(this.failure);
}
