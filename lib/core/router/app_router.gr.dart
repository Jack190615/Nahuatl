// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BlogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlogView(),
      );
    },
    DictionarySearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DictionarySearchView(),
      );
    },
    ExerciseSessionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ExerciseSessionRouteArgs>(
          orElse: () => ExerciseSessionRouteArgs(
              lessonId: pathParams.getInt('lessonId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExerciseSessionView(
          key: args.key,
          lessonId: args.lessonId,
          lessonTitle: args.lessonTitle,
        ),
      );
    },
    LessonMapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LessonMapView(),
      );
    },
    LessonTheoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LessonTheoryRouteArgs>(
          orElse: () =>
              LessonTheoryRouteArgs(lessonId: pathParams.getInt('lessonId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LessonTheoryView(
          key: args.key,
          lessonId: args.lessonId,
          lessonTitle: args.lessonTitle,
        ),
      );
    },
    MainShellRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainShellView(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeView(),
      );
    },
  };
}

/// generated route for
/// [BlogView]
class BlogRoute extends PageRouteInfo<void> {
  const BlogRoute({List<PageRouteInfo>? children})
      : super(
          BlogRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DictionarySearchView]
class DictionarySearchRoute extends PageRouteInfo<void> {
  const DictionarySearchRoute({List<PageRouteInfo>? children})
      : super(
          DictionarySearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'DictionarySearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseSessionView]
class ExerciseSessionRoute extends PageRouteInfo<ExerciseSessionRouteArgs> {
  ExerciseSessionRoute({
    Key? key,
    required int lessonId,
    String lessonTitle = 'Práctica de Lección',
    List<PageRouteInfo>? children,
  }) : super(
          ExerciseSessionRoute.name,
          args: ExerciseSessionRouteArgs(
            key: key,
            lessonId: lessonId,
            lessonTitle: lessonTitle,
          ),
          rawPathParams: {'lessonId': lessonId},
          initialChildren: children,
        );

  static const String name = 'ExerciseSessionRoute';

  static const PageInfo<ExerciseSessionRouteArgs> page =
      PageInfo<ExerciseSessionRouteArgs>(name);
}

class ExerciseSessionRouteArgs {
  const ExerciseSessionRouteArgs({
    this.key,
    required this.lessonId,
    this.lessonTitle = 'Práctica de Lección',
  });

  final Key? key;

  final int lessonId;

  final String lessonTitle;

  @override
  String toString() {
    return 'ExerciseSessionRouteArgs{key: $key, lessonId: $lessonId, lessonTitle: $lessonTitle}';
  }
}

/// generated route for
/// [LessonMapView]
class LessonMapRoute extends PageRouteInfo<void> {
  const LessonMapRoute({List<PageRouteInfo>? children})
      : super(
          LessonMapRoute.name,
          initialChildren: children,
        );

  static const String name = 'LessonMapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LessonTheoryView]
class LessonTheoryRoute extends PageRouteInfo<LessonTheoryRouteArgs> {
  LessonTheoryRoute({
    Key? key,
    required int lessonId,
    String lessonTitle = 'Teoría de la Lección',
    List<PageRouteInfo>? children,
  }) : super(
          LessonTheoryRoute.name,
          args: LessonTheoryRouteArgs(
            key: key,
            lessonId: lessonId,
            lessonTitle: lessonTitle,
          ),
          rawPathParams: {'lessonId': lessonId},
          initialChildren: children,
        );

  static const String name = 'LessonTheoryRoute';

  static const PageInfo<LessonTheoryRouteArgs> page =
      PageInfo<LessonTheoryRouteArgs>(name);
}

class LessonTheoryRouteArgs {
  const LessonTheoryRouteArgs({
    this.key,
    required this.lessonId,
    this.lessonTitle = 'Teoría de la Lección',
  });

  final Key? key;

  final int lessonId;

  final String lessonTitle;

  @override
  String toString() {
    return 'LessonTheoryRouteArgs{key: $key, lessonId: $lessonId, lessonTitle: $lessonTitle}';
  }
}

/// generated route for
/// [MainShellView]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
      : super(
          MainShellRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainShellRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeView]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
