# PerfectTemplateFCGI
Perfect Empty Starter FastCGI Project

This repository holds a blank Perfect project which can be cloned to serve as a starter for new work. It builds with Swift Package Manager and produces a FastCGI based server executable.

**The master branch of this project currently compiles with *DEVELOPMENT-SNAPSHOT-2016-06-20-a* released June 20th, 2016 using Swift Package Manager.**

Ensure that you have installed the few dependencies which Perfect requires for your platform:

[Dependencies](https://github.com/PerfectlySoft/Perfect/wiki/Dependencies)

This server can run with any FastCGI enabled webserver over either UNIX socket files or TCP.

## Apache 24
To run with Apache 2.4, build and install the mod_perfect FastCGI module:

[Perfect-FastCGI-Apache2.4](https://github.com/PerfectlySoft/Perfect-FastCGI-Apache2.4)

## NGINX
Instructions for running with NGINX:

[NGINX](https://github.com/PerfectlySoft/Perfect/wiki/NGINX)

## Building & Running

The following will clone and build an empty starter project and launch the server.

```
git clone https://github.com/PerfectlySoft/PerfectTemplateFCGI.git
cd PerfectTemplateFCGI
swift build
.build/debug/PerfectTemplateFCGI
```

You should see the following output:

```
Starting FastCGI server on named pipe /Library/WebServer/VirtualHosts/perfect.fastcgi.sock
```

This means the server is running and waiting for connections.

## Starter Content

The template file contains a very simple "hello, world!" example. Note that you must install mod_perfect or otherwise configure your web server for FastCGI and change the namedPipe path such that it points one level above your server's document root.

```swift
import PerfectLib
import PerfectFastCGI

// Initialize base-level services
PerfectServer.initializeServices()

Routing.Routes["/**"] = {
    req, resp in
    let path = req.path
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
```

## Repository Layout

We have finished refactoring Perfect to support Swift Package Manager. The Perfect project has been split up into the following repositories:

* [Perfect](https://github.com/PerfectlySoft/Perfect) - This repository contains the core PerfectLib and will continue to be the main landing point for the project.
* [PerfectTemplate](https://github.com/PerfectlySoft/PerfectTemplate) - A simple starter project which compiles with SPM into a stand-alone executable HTTP server. This repository is ideal for starting on your own Perfect based project.
* [PerfectDocs](https://github.com/PerfectlySoft/PerfectDocs) - Contains all API reference related material.
* [PerfectExamples](https://github.com/PerfectlySoft/PerfectExamples) - All the Perfect example projects and documentation.
* [PerfectEverything](https://github.com/PerfectlySoft/PerfectEverything) - This umbrella repository allows one to pull in all the related Perfect modules in one go, including the servers, examples, database connectors and documentation. This is a great place to start for people wishing to get up to speed with Perfect.
* [PerfectServer](https://github.com/PerfectlySoft/PerfectServer) - Contains the PerfectServer variants, including the stand-alone HTTP and FastCGI servers. Those wishing to do a manual deployment should clone and build from this repository.
* [Perfect-Redis](https://github.com/PerfectlySoft/Perfect-Redis) - Redis database connector.
* [Perfect-SQLite](https://github.com/PerfectlySoft/Perfect-SQLite) - SQLite3 database connector.
* [Perfect-PostgreSQL](https://github.com/PerfectlySoft/Perfect-PostgreSQL) - PostgreSQL database connector.
* [Perfect-MySQL](https://github.com/PerfectlySoft/Perfect-MySQL) - MySQL database connector.
* [Perfect-MongoDB](https://github.com/PerfectlySoft/Perfect-MongoDB) - MongoDB database connector.
* [Perfect-FastCGI-Apache2.4](https://github.com/PerfectlySoft/Perfect-FastCGI-Apache2.4) - Apache 2.4 FastCGI module; required for the Perfect FastCGI server variant.

The database connectors are all stand-alone and can be used outside of the Perfect framework and server.

## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
