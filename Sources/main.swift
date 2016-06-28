//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectFastCGI

// Initialize base-level services
PerfectServer.initializeServices()

Routing.Routes["/**"] = {
    req, resp in
    resp.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    resp.completed()
}

do {
    // Launch the FastCGI server
    // The path to the sock file must point to a directory one level up from the site's document root.
    // The file must be called "perfect.fastcgi.sock"
    // For example, the following path would suffice for a server whose document root is:
    // /Library/WebServer/VirtualHosts/wwwroot/
    try FastCGIServer().start(namedPipe: "/Library/WebServer/VirtualHosts/perfect.fastcgi.sock")
} catch {
    print("Error thrown: \(error)")
}
