// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library analyzer.test.src.context.mock_sdk;

import 'package:analyzer/file_system/file_system.dart' as resource;
import 'package:analyzer/file_system/memory_file_system.dart' as resource;
import 'package:analyzer/src/context/cache.dart';
import 'package:analyzer/src/context/context.dart';
import 'package:analyzer/src/generated/engine.dart' show AnalysisEngine;
import 'package:analyzer/src/generated/sdk.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/summary/idl.dart' show PackageBundle;
import 'package:analyzer/src/summary/summary_file_builder.dart';

const String librariesContent = r'''
const Map<String, LibraryInfo> libraries = const {
  "async": const LibraryInfo("async/async.dart"),
  "collection": const LibraryInfo("collection/collection.dart"),
  "convert": const LibraryInfo("convert/convert.dart"),
  "core": const LibraryInfo("core/core.dart"),
  "html": const LibraryInfo(
    "html/dartium/html_dartium.dart",
    dart2jsPath: "html/dart2js/html_dart2js.dart"),
  "math": const LibraryInfo("math/math.dart"),
  "_foreign_helper": const LibraryInfo("_internal/js_runtime/lib/foreign_helper.dart"),
};
''';

const String sdkRoot = '/sdk';

const _MockSdkLibrary _LIB_ASYNC = const _MockSdkLibrary(
    'dart:async',
    '$sdkRoot/lib/async/async.dart',
    '''
library dart.async;

import 'dart:math';

part 'stream.dart';

class Future<T> {
  factory Future(computation()) => null;
  factory Future.delayed(Duration duration, [T computation()]) => null;
  factory Future.value([T value]) => null;

  static Future<List/*<T>*/> wait/*<T>*/(
      Iterable<Future/*<T>*/> futures) => null;
  Future/*<R>*/ then/*<R>*/(onValue(T value)) => null;

  Future<T> whenComplete(action());
}

abstract class Completer<T> {
  factory Completer() => new _AsyncCompleter<T>();
  factory Completer.sync() => new _SyncCompleter<T>();
  Future<T> get future;
  void complete([value]);
  void completeError(Object error, [StackTrace stackTrace]);
  bool get isCompleted;
}
''',
    const <String, String>{
      '$sdkRoot/lib/async/stream.dart': r'''
part of dart.async;
class Stream<T> {
  Future<T> get first;
}
abstract class StreamTransformer<S, T> {}
'''
    });

const _MockSdkLibrary _LIB_COLLECTION = const _MockSdkLibrary(
    'dart:collection',
    '$sdkRoot/lib/collection/collection.dart',
    '''
library dart.collection;

abstract class HashMap<K, V> implements Map<K, V> {}
''');

const _MockSdkLibrary _LIB_CONVERT = const _MockSdkLibrary(
    'dart:convert',
    '$sdkRoot/lib/convert/convert.dart',
    '''
library dart.convert;

import 'dart:async';

abstract class Converter<S, T> implements StreamTransformer {}
class JsonDecoder extends Converter<String, Object> {}
''');

const _MockSdkLibrary _LIB_CORE = const _MockSdkLibrary(
    'dart:core',
    '$sdkRoot/lib/core/core.dart',
    '''
library dart.core;

import 'dart:async';

class Object {
  bool operator ==(other) => identical(this, other);
  String toString() => 'a string';
  int get hashCode => 0;
}

class Function {}
class StackTrace {}
class Symbol {}
class Type {}

abstract class Comparable<T> {
  int compareTo(T other);
}

abstract class Pattern {}
abstract class String implements Comparable<String>, Pattern {
  external factory String.fromCharCodes(Iterable<int> charCodes,
                                        [int start = 0, int end]);
  String operator +(String other) => null;
  bool get isEmpty => false;
  bool get isNotEmpty => false;
  int get length => 0;
  String substring(int len) => null;
  String toUpperCase();
  List<int> get codeUnits;
}
abstract class RegExp implements Pattern {
  external factory RegExp(String source);
}

class bool extends Object {}
abstract class num implements Comparable<num> {
  bool operator <(num other);
  bool operator <=(num other);
  bool operator >(num other);
  bool operator >=(num other);
  num operator +(num other);
  num operator -(num other);
  num operator *(num other);
  num operator /(num other);
  int operator ^(int other);
  int operator &(int other);
  int operator |(int other);
  int operator <<(int other);
  int operator >>(int other);
  int operator ~/(num other);
  num operator %(num other);
  int operator ~();
  int toInt();
  double toDouble();
  num abs();
  int round();
}
abstract class int extends num {
  bool get isEven => false;
  int operator -();
  external static int parse(String source,
                            { int radix,
                              int onError(String source) });
}

abstract class double extends num {
  static const double NAN = 0.0 / 0.0;
  static const double INFINITY = 1.0 / 0.0;
  static const double NEGATIVE_INFINITY = -INFINITY;
  static const double MIN_POSITIVE = 5e-324;
  static const double MAX_FINITE = 1.7976931348623157e+308;

  double remainder(num other);
  double operator +(num other);
  double operator -(num other);
  double operator *(num other);
  double operator %(num other);
  double operator /(num other);
  int operator ~/(num other);
  double operator -();
  double abs();
  double get sign;
  int round();
  int floor();
  int ceil();
  int truncate();
  double roundToDouble();
  double floorToDouble();
  double ceilToDouble();
  double truncateToDouble();
  external static double parse(String source,
                               [double onError(String source)]);
}

class DateTime extends Object {}
class Null extends Object {}

class Deprecated extends Object {
  final String expires;
  const Deprecated(this.expires);
}
const Object deprecated = const Deprecated("next release");

class Iterator<E> {
  bool moveNext();
  E get current;
}

abstract class Iterable<E> {
  Iterator<E> get iterator;
  bool get isEmpty;
  E get first;

  Iterable/*<R>*/ map/*<R>*/(/*=R*/ f(E e));

  /*=R*/ fold/*<R>*/(/*=R*/ initialValue,
      /*=R*/ combine(/*=R*/ previousValue, E element));

  Iterable/*<T>*/ expand/*<T>*/(Iterable/*<T>*/ f(E element));

  List<E> toList();
}

class List<E> implements Iterable<E> {
  List();
  void add(E value) {}
  void addAll(Iterable<E> iterable) {}
  E operator [](int index) => null;
  void operator []=(int index, E value) {}
  Iterator<E> get iterator => null;
  void clear() {}

  bool get isEmpty => false;
  E get first => null;

  Iterable/*<R>*/ map/*<R>*/(/*=R*/ f(E e)) => null;

  /*=R*/ fold/*<R>*/(/*=R*/ initialValue,
      /*=R*/ combine(/*=R*/ previousValue, E element)) => null;

}

class Map<K, V> extends Object {
  Iterable<K> get keys => null;
  V operator [](K key) => null;
  void operator []=(K key, V value) {}
}

external bool identical(Object a, Object b);

void print(Object object) {}

class _Proxy { const _Proxy(); }
const Object proxy = const _Proxy();

class _Override { const _Override(); }
const Object override = const _Override();
''');

const _MockSdkLibrary _LIB_FOREIGN_HELPER = const _MockSdkLibrary(
    'dart:_foreign_helper',
    '$sdkRoot/lib/_foreign_helper/_foreign_helper.dart',
    '''
library dart._foreign_helper;

JS(String typeDescription, String codeTemplate,
  [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11])
{}
''');

const _MockSdkLibrary _LIB_HTML_DART2JS = const _MockSdkLibrary(
    'dart:html',
    '$sdkRoot/lib/html/dart2js/html_dart2js.dart',
    '''
library dart.html;
class HtmlElement {}
''');

const _MockSdkLibrary _LIB_HTML_DARTIUM = const _MockSdkLibrary(
    'dart:html',
    '$sdkRoot/lib/html/dartium/html_dartium.dart',
    '''
library dart.html;
class HtmlElement {}
''');

const _MockSdkLibrary _LIB_MATH = const _MockSdkLibrary(
    'dart:math',
    '$sdkRoot/lib/math/math.dart',
    '''
library dart.math;

const double E = 2.718281828459045;
const double PI = 3.1415926535897932;
const double LN10 =  2.302585092994046;

num/*=T*/ min/*<T extends num>*/(num/*=T*/ a, num/*=T*/ b) => null;
num/*=T*/ max/*<T extends num>*/(num/*=T*/ a, num/*=T*/ b) => null;

external double cos(num x);
external double sin(num x);
external double sqrt(num x);
class Random {
  bool nextBool() => true;
  double nextDouble() => 2.0;
  int nextInt() => 1;
}
''');

const List<SdkLibrary> _LIBRARIES = const [
  _LIB_CORE,
  _LIB_ASYNC,
  _LIB_COLLECTION,
  _LIB_CONVERT,
  _LIB_FOREIGN_HELPER,
  _LIB_MATH,
  _LIB_HTML_DART2JS,
  _LIB_HTML_DARTIUM,
];

class MockSdk implements DartSdk {
  static const Map<String, String> FULL_URI_MAP = const {
    "dart:core": "$sdkRoot/lib/core/core.dart",
    "dart:html": "$sdkRoot/lib/html/dartium/html_dartium.dart",
    "dart:async": "$sdkRoot/lib/async/async.dart",
    "dart:async/stream.dart": "$sdkRoot/lib/async/stream.dart",
    "dart:collection": "$sdkRoot/lib/collection/collection.dart",
    "dart:convert": "$sdkRoot/lib/convert/convert.dart",
    "dart:_foreign_helper": "$sdkRoot/lib/_foreign_helper/_foreign_helper.dart",
    "dart:math": "$sdkRoot/lib/math/math.dart"
  };

  static const Map<String, String> NO_ASYNC_URI_MAP = const {
    "dart:core": "$sdkRoot/lib/core/core.dart",
  };

  final resource.MemoryResourceProvider provider;

  final Map<String, String> uriMap;

  /**
   * The [AnalysisContextImpl] which is used for all of the sources.
   */
  AnalysisContextImpl _analysisContext;

  @override
  final List<SdkLibrary> sdkLibraries;

  /**
   * The cached linked bundle of the SDK.
   */
  PackageBundle _bundle;

  MockSdk(
      {bool dartAsync: true, resource.MemoryResourceProvider resourceProvider})
      : provider = resourceProvider ?? new resource.MemoryResourceProvider(),
        sdkLibraries = dartAsync ? _LIBRARIES : [_LIB_CORE],
        uriMap = dartAsync ? FULL_URI_MAP : NO_ASYNC_URI_MAP {
    for (_MockSdkLibrary library in sdkLibraries) {
      provider.newFile(provider.convertPath(library.path), library.content);
      library.parts.forEach((String path, String content) {
        provider.newFile(provider.convertPath(path), content);
      });
    }
    provider.newFile(
        provider.convertPath(
            '$sdkRoot/lib/_internal/sdk_library_metadata/lib/libraries.dart'),
        librariesContent);
  }

  @override
  AnalysisContextImpl get context {
    if (_analysisContext == null) {
      _analysisContext = new _SdkAnalysisContext(this);
      SourceFactory factory = new SourceFactory([new DartUriResolver(this)]);
      _analysisContext.sourceFactory = factory;
    }
    return _analysisContext;
  }

  @override
  String get sdkVersion => throw new UnimplementedError();

  @override
  List<String> get uris =>
      sdkLibraries.map((SdkLibrary library) => library.shortName).toList();

  @override
  Source fromFileUri(Uri uri) {
    String filePath = uri.path;
    String libPath = '$sdkRoot/lib';
    if (!filePath.startsWith("$libPath/")) {
      return null;
    }
    for (SdkLibrary library in sdkLibraries) {
      String libraryPath = library.path;
      if (filePath.replaceAll('\\', '/') == libraryPath) {
        try {
          resource.File file =
              provider.getResource(provider.convertPath(filePath));
          Uri dartUri = Uri.parse(library.shortName);
          return file.createSource(dartUri);
        } catch (exception) {
          return null;
        }
      }
      if (filePath.startsWith("$libraryPath/")) {
        String pathInLibrary = filePath.substring(libraryPath.length + 1);
        String path = '${library.shortName}/$pathInLibrary';
        try {
          resource.File file =
              provider.getResource(provider.convertPath(filePath));
          Uri dartUri = new Uri(scheme: 'dart', path: path);
          return file.createSource(dartUri);
        } catch (exception) {
          return null;
        }
      }
    }
    return null;
  }

  @override
  PackageBundle getLinkedBundle() {
    if (_bundle == null) {
      List<Source> librarySources = sdkLibraries
          .map((SdkLibrary library) => mapDartUri(library.shortName))
          .toList();
      List<int> bytes = new SummaryBuilder(
              librarySources, context, context.analysisOptions.strongMode)
          .build();
      _bundle = new PackageBundle.fromBuffer(bytes);
    }
    return _bundle;
  }

  @override
  SdkLibrary getSdkLibrary(String dartUri) {
    // getSdkLibrary() is only used to determine whether a library is internal
    // to the SDK.  The mock SDK doesn't have any internals, so it's safe to
    // return null.
    return null;
  }

  @override
  Source mapDartUri(String dartUri) {
    String path = uriMap[dartUri];
    if (path != null) {
      resource.File file = provider.getResource(provider.convertPath(path));
      Uri uri = new Uri(scheme: 'dart', path: dartUri.substring(5));
      return file.createSource(uri);
    }
    // If we reach here then we tried to use a dartUri that's not in the
    // table above.
    return null;
  }

  /**
   * This method is used to apply patches to [MockSdk].  It may be called only
   * before analysis, i.e. before the analysis context was created.
   */
  void updateUriFile(String uri, String updateContent(String content)) {
    assert(_analysisContext == null);
    String path = FULL_URI_MAP[uri];
    assert(path != null);
    path = provider.convertPath(path);
    String content = provider.getFile(path).readAsStringSync();
    String newContent = updateContent(content);
    provider.updateFile(path, newContent);
  }
}

class _MockSdkLibrary implements SdkLibrary {
  final String shortName;
  final String path;
  final String content;
  final Map<String, String> parts;

  const _MockSdkLibrary(this.shortName, this.path, this.content,
      [this.parts = const <String, String>{}]);

  @override
  String get category => throw new UnimplementedError();

  @override
  bool get isDart2JsLibrary => throw new UnimplementedError();

  @override
  bool get isDocumented => throw new UnimplementedError();

  @override
  bool get isImplementation => throw new UnimplementedError();

  @override
  bool get isInternal => throw new UnimplementedError();

  @override
  bool get isShared => throw new UnimplementedError();

  @override
  bool get isVmLibrary => throw new UnimplementedError();

  @override
  List<String> getPatches(int platform) => const <String>[];
}

/**
 * An [AnalysisContextImpl] that only contains sources for a Dart SDK.
 */
class _SdkAnalysisContext extends AnalysisContextImpl {
  final DartSdk sdk;

  _SdkAnalysisContext(this.sdk);

  @override
  AnalysisCache createCacheFromSourceFactory(SourceFactory factory) {
    if (factory == null) {
      return super.createCacheFromSourceFactory(factory);
    }
    return new AnalysisCache(
        <CachePartition>[AnalysisEngine.instance.partitionManager.forSdk(sdk)]);
  }
}
