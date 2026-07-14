/*
 * Copyright 1999-2101 Alibaba Group.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  CBridge.swift
//  HandyJSON
//
//  Created by chantu on 2018/7/15.
//  Copyright © 2018 aliyun. All rights reserved.
//

import Foundation

private typealias RuntimeTypeLookup = @convention(c) (
    UnsafePointer<UInt8>?,
    Int,
    UnsafeRawPointer?,
    UnsafeRawPointer?) -> UnsafeRawPointer?

private let runtimeTypeLookup: RuntimeTypeLookup? = {
    #if canImport(Darwin)
    guard let handle = dlopen(nil, RTLD_NOW),
          let symbol = dlsym(handle, "swift_getTypeByMangledNameInContext") else {
        return nil
    }
    #elseif canImport(Glibc)
    guard let handle = dlopen(nil, RTLD_NOW),
          let symbol = dlsym(handle, "swift_getTypeByMangledNameInContext") else {
        return nil
    }
    #else
    return nil
    #endif

    return unsafeBitCast(symbol, to: RuntimeTypeLookup.self)
}()

public func _getTypeByMangledNameInContext(
    _ name: UnsafePointer<UInt8>,
    _ nameLength: Int,
    genericContext: UnsafeRawPointer?,
    genericArguments: UnsafeRawPointer?) -> Any.Type? {
    guard let typeMetadata = runtimeTypeLookup?(name, nameLength, genericContext, genericArguments) else {
        return nil
    }
    return unsafeBitCast(typeMetadata, to: Any.Type.self)
}


@_silgen_name("swift_getTypeContextDescriptor")
public func _swift_getTypeContextDescriptor(_ metadata: UnsafeRawPointer?) -> UnsafeRawPointer?
