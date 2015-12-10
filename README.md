# Docker
A Dart wrapper around the Docker command line. 
Mainly thought as a helper-library for Grinder.

## Basic usage
```dart
@Task("Stop containers")
dockerStopp() {
    ["db-webappbase-test", "db-mobiad-test"].forEach((final String container) {
        log("Stopping container: $container");
            new Docker()..stop([container ],quiet: true);
    });
}

@Task("Start container")
@Depends(dockerStopp)
dockerStart() {
    new Docker()..start([ "db-webappbase-test" ],quiet: true);
}

@Task("Check if container runs and if container is available")
containerCheck() async {
    final Docker docker = new Docker();

    [ "db-mobiad-test"].forEach((final String name) => docker.stop([ name ]));
    docker.start([ containerNameToCheck] );

    final Container container = new Container(runningContainerIDs());
    if(!container.names.contains(containerNameToCheck)) {

        container.names.forEach((final String name) {
            log("Active containers: -${name}-");
        });

        throw new ArgumentError("${containerNameToCheck} must be running for this test!");
    }
}
```

## Docker JSON API
If you need want to dive into Dockers JSON-API check out [bwu_docker](https://pub.dartlang.org/packages/bwu_docker)

## Features and bugs
Please file feature requests and bugs at the [issue tracker](https://github.com/MikeMitterer/dart-docker/issues).

## License

    Copyright 2015 Michael Mitterer (office@mikemitterer.at),
    IT-Consulting and Development Limited, Austrian Branch

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
    either express or implied. See the License for the specific language
    governing permissions and limitations under the License.


If this plugin is helpful for you - please [(Circle)](http://gplus.mikemitterer.at/) me
or **star** this repo here on GitHub
