// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class _MirrorReference {
  factory _MirrorReference._uninstantiable() {
    throw new UnsupportedError("class _MirrorReference cannot be instantiated");
  }

  bool operator ==(other) native "MirrorReference_equals";
}
