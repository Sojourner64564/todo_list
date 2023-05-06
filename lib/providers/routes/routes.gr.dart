// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:auto_route/empty_router_widgets.dart' as _i2;
import 'package:flutter/material.dart' as _i8;

import '../../presentation/cubit/cubit.dart' as _i9;
import '../../presentation/cubit/makeGroupsListCubit.dart' as _i11;
import '../../presentation/cubit/tasksUpdateCubit.dart' as _i10;
import '../../widgets/app/my_app.dart' as _i1;
import '../../widgets/group_form/group_form_widget.dart' as _i6;
import '../../widgets/groups/groups_widget.dart' as _i3;
import '../../widgets/task_form/task_form_widget.dart' as _i5;
import '../../widgets/tasks/tasks_widget.dart' as _i4;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    GroupsFormsEmptyRouterPageRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    GroupsWidgetRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.GroupsWidget(),
      );
    },
    TasksWidgetRouter.name: (routeData) {
      final args = routeData.argsAs<TasksWidgetRouterArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.TasksWidget(
          updateCubit: args.updateCubit,
          groupKey: args.groupKey,
          tasksUpdateCubit: args.tasksUpdateCubit,
          index: args.index,
          makeGroupsListCubit: args.makeGroupsListCubit,
        ),
      );
    },
    TaskFormWidgetRouter.name: (routeData) {
      final args = routeData.argsAs<TaskFormWidgetRouterArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.TaskFormWidget(
          updateCubit: args.updateCubit,
          tasksUpdateCubit: args.tasksUpdateCubit,
          makeGroupsListCubit: args.makeGroupsListCubit,
        ),
      );
    },
    GroupFormWidgetRouter.name: (routeData) {
      final args = routeData.argsAs<GroupFormWidgetRouterArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.GroupFromWidget(
          updateCubit: args.updateCubit,
          makeGroupsListCubit: args.makeGroupsListCubit,
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i7.RouteConfig(
              GroupsFormsEmptyRouterPageRouter.name,
              path: '',
              parent: HomeRoute.name,
              children: [
                _i7.RouteConfig(
                  GroupsWidgetRouter.name,
                  path: '',
                  parent: GroupsFormsEmptyRouterPageRouter.name,
                ),
                _i7.RouteConfig(
                  TasksWidgetRouter.name,
                  path: 'Tasks',
                  parent: GroupsFormsEmptyRouterPageRouter.name,
                ),
                _i7.RouteConfig(
                  TaskFormWidgetRouter.name,
                  path: 'TaksForm',
                  parent: GroupsFormsEmptyRouterPageRouter.name,
                ),
                _i7.RouteConfig(
                  GroupFormWidgetRouter.name,
                  path: 'GroupForm',
                  parent: GroupsFormsEmptyRouterPageRouter.name,
                ),
              ],
            )
          ],
        )
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class GroupsFormsEmptyRouterPageRouter extends _i7.PageRouteInfo<void> {
  const GroupsFormsEmptyRouterPageRouter({List<_i7.PageRouteInfo>? children})
      : super(
          GroupsFormsEmptyRouterPageRouter.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'GroupsFormsEmptyRouterPageRouter';
}

/// generated route for
/// [_i3.GroupsWidget]
class GroupsWidgetRouter extends _i7.PageRouteInfo<void> {
  const GroupsWidgetRouter()
      : super(
          GroupsWidgetRouter.name,
          path: '',
        );

  static const String name = 'GroupsWidgetRouter';
}

/// generated route for
/// [_i4.TasksWidget]
class TasksWidgetRouter extends _i7.PageRouteInfo<TasksWidgetRouterArgs> {
  TasksWidgetRouter({
    required _i9.UpdateCubit updateCubit,
    required int groupKey,
    required _i10.TasksUpdateCubit tasksUpdateCubit,
    required int index,
    required _i11.MakeGroupsListCubit makeGroupsListCubit,
  }) : super(
          TasksWidgetRouter.name,
          path: 'Tasks',
          args: TasksWidgetRouterArgs(
            updateCubit: updateCubit,
            groupKey: groupKey,
            tasksUpdateCubit: tasksUpdateCubit,
            index: index,
            makeGroupsListCubit: makeGroupsListCubit,
          ),
        );

  static const String name = 'TasksWidgetRouter';
}

class TasksWidgetRouterArgs {
  const TasksWidgetRouterArgs({
    required this.updateCubit,
    required this.groupKey,
    required this.tasksUpdateCubit,
    required this.index,
    required this.makeGroupsListCubit,
  });

  final _i9.UpdateCubit updateCubit;

  final int groupKey;

  final _i10.TasksUpdateCubit tasksUpdateCubit;

  final int index;

  final _i11.MakeGroupsListCubit makeGroupsListCubit;

  @override
  String toString() {
    return 'TasksWidgetRouterArgs{updateCubit: $updateCubit, groupKey: $groupKey, tasksUpdateCubit: $tasksUpdateCubit, index: $index, makeGroupsListCubit: $makeGroupsListCubit}';
  }
}

/// generated route for
/// [_i5.TaskFormWidget]
class TaskFormWidgetRouter extends _i7.PageRouteInfo<TaskFormWidgetRouterArgs> {
  TaskFormWidgetRouter({
    required _i9.UpdateCubit updateCubit,
    required _i10.TasksUpdateCubit tasksUpdateCubit,
    required _i11.MakeGroupsListCubit makeGroupsListCubit,
  }) : super(
          TaskFormWidgetRouter.name,
          path: 'TaksForm',
          args: TaskFormWidgetRouterArgs(
            updateCubit: updateCubit,
            tasksUpdateCubit: tasksUpdateCubit,
            makeGroupsListCubit: makeGroupsListCubit,
          ),
        );

  static const String name = 'TaskFormWidgetRouter';
}

class TaskFormWidgetRouterArgs {
  const TaskFormWidgetRouterArgs({
    required this.updateCubit,
    required this.tasksUpdateCubit,
    required this.makeGroupsListCubit,
  });

  final _i9.UpdateCubit updateCubit;

  final _i10.TasksUpdateCubit tasksUpdateCubit;

  final _i11.MakeGroupsListCubit makeGroupsListCubit;

  @override
  String toString() {
    return 'TaskFormWidgetRouterArgs{updateCubit: $updateCubit, tasksUpdateCubit: $tasksUpdateCubit, makeGroupsListCubit: $makeGroupsListCubit}';
  }
}

/// generated route for
/// [_i6.GroupFromWidget]
class GroupFormWidgetRouter
    extends _i7.PageRouteInfo<GroupFormWidgetRouterArgs> {
  GroupFormWidgetRouter({
    required _i9.UpdateCubit updateCubit,
    required _i11.MakeGroupsListCubit makeGroupsListCubit,
  }) : super(
          GroupFormWidgetRouter.name,
          path: 'GroupForm',
          args: GroupFormWidgetRouterArgs(
            updateCubit: updateCubit,
            makeGroupsListCubit: makeGroupsListCubit,
          ),
        );

  static const String name = 'GroupFormWidgetRouter';
}

class GroupFormWidgetRouterArgs {
  const GroupFormWidgetRouterArgs({
    required this.updateCubit,
    required this.makeGroupsListCubit,
  });

  final _i9.UpdateCubit updateCubit;

  final _i11.MakeGroupsListCubit makeGroupsListCubit;

  @override
  String toString() {
    return 'GroupFormWidgetRouterArgs{updateCubit: $updateCubit, makeGroupsListCubit: $makeGroupsListCubit}';
  }
}
