import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../widgets/app/my_app.dart';
import '../../widgets/group_form/group_form_widget.dart';
import '../../widgets/groups/groups_widget.dart';
import '../../widgets/task_form/task_form_widget.dart';
import '../../widgets/tasks/tasks_widget.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/',  page: HomePage, children: [
      AutoRoute(
        path: '',
        initial: true,
        name: 'GroupsFormsEmptyRouterPageRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            name:'GroupsWidgetRouter',
            page: GroupsWidget,
          ),
          AutoRoute(
            path: 'Tasks',
            name:'TasksWidgetRouter',
            page: TasksWidget,
          ),
          AutoRoute(
            path: 'TaksForm',
            name:'TaskFormWidgetRouter',
            page: TaskFormWidget,
          ),

          AutoRoute(
            path: 'GroupForm',
            name:'GroupFormWidgetRouter',
            page: GroupFromWidget,
          ),
        ],
      ),
    ],
    ),
  ],
)
class $AppRouter {}


/*
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/',  page: HomePage, children: [
      AutoRoute(
        path: 'GroupsForms',initial: true,
        name: 'GroupsFormsEmptyRouterPageRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            name:'GroupsWidgetRouter',
            page: GroupsWidget,
          ),
          AutoRoute(
            path: '',
            name:'GroupFormWidgetRouter',
            page: GroupFromWidget,
          ),
        ],
      ),
      AutoRoute(
        path:'',
        name:'TasksFormsWidgetRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            name:'TasksWidgetRouter',
            page: TasksWidget,
          ),
          AutoRoute(
            path: '',
            name:'TaskFormWidgetRouter',
            page: TaskFormWidget,
          ),
        ],
      ),
    ],
    ),
  ],
)
class $AppRouter {}

* */








/*
 @MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    routes: <AutoRoute>[
      AutoRoute(
          path: '/',
          initial: true,
          page: HomePage,
          children: [
            AutoRoute(
              path: 'groupsWidget',
              name: 'GroupsWidgetRouter',
              page: EmptyRouterPage,
              children: [
                AutoRoute(
                  path: '',
                  page: GroupsWidget,
                ),
                AutoRoute(
                  path: 'groupFormWidget',
                  page: GroupFromWidget,
                ),
              ],
            ),
          ]
      ),
],
)
class $AppRouter {}*/
