/*
 * Copyright (c) 2015, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 * 
 * All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
     
part of docker;

/// Returns all Docker-Container-IDs
UnmodifiableListView<String> allContainerIDs({ final Docker docker: const Docker() }) {
    final String allContainers = docker.ps([ "-a", "-q" ],quiet: true);
    return new UnmodifiableListView<String>(
        allContainers.split("\n").where(((final String container) => container.trim().isNotEmpty)));
}

/// Returns Docker-Container-IDs for active/running containers
UnmodifiableListView<String> runningContainerIDs({ final Docker docker: const Docker() }) {
    final String allContainers = docker.ps([ "-q" ],quiet: true);
    return new UnmodifiableListView<String>(
        allContainers.split("\n").where(((final String container) => container.trim().isNotEmpty)));
}

/// Wrapper for Docker containers
///
///     final Container container = new Container(runningContainerIDs());
///     container.names.forEach((final String name) {
///        log("Active containers: -${name}-");
///     });
///
class Container {
    // final Logger _logger = new Logger('docker.Container');

    final Docker _docker;
    final UnmodifiableListView<String> _containerList;

    /// [_containerList] comes from [allContainerIDs] or [runningContainerIDs]
    Container(this._containerList) : _docker = new Docker() {
        Validate.notNull(_containerList);
    }

    /// For testing - [_docker] sets a mocked [Docker]-Version
    Container.withDocker(this._containerList,this._docker) {
        Validate.notNull(_containerList);
        Validate.notNull(_docker);
    }

    /// Converts Container-Id to Container-Name
    String toName(final String containerid) {
        Validate.notBlank(containerid);

        return _docker.inspect([ "--format='{{.Name}}'", containerid ],quiet: true)
            .replaceFirst("/","").trim();
    }

    /// Converts Container-Id to Image-Name
    String toImage(final String containerid) {
        Validate.notBlank(containerid);

        return _docker.inspect([ "--format='{{.Config.Image}}'", containerid ],quiet: true).trim();
    }

    /// All available Container-names.
    UnmodifiableListView<String> get names {
        final List<String> names = new List<String>();

        _containerList.forEach((final String containerid) => names.add(toName(containerid)));

        return new UnmodifiableListView<String>(names);
    }

    /// All available Container-image-names
    UnmodifiableListView<String> get images {
        final List<String> images = new List<String>();

        _containerList.forEach((final String containerid) => images.add(toImage(containerid)));

        return new UnmodifiableListView<String>(images);
    }
}
