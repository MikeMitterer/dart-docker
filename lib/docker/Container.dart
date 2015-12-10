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

class Container {
    // final Logger _logger = new Logger('docker.Container');

    final UnmodifiableListView<String> _containerList;

    Container(this._containerList);

    static UnmodifiableListView<String> get all {
        final String allContainers = Docker.ps([ "-a", "-q" ],quiet: true);
        return new UnmodifiableListView<String>(
            allContainers.split("\n").where(((final String container) => container.trim().isNotEmpty)));
    }

    static UnmodifiableListView<String> get running {
        final String allContainers = Docker.ps([ "-q" ],quiet: true);
        return new UnmodifiableListView<String>(
            allContainers.split("\n").where(((final String container) => container.trim().isNotEmpty)));
    }

    static String toName(final String containerid) {
        return Docker.inspect([ "--format='{{.Name}}'", containerid ],quiet: true)
            .replaceFirst("/","").trim();
    }

    static String toImage(final String containerid) {
        return Docker.inspect([ "--format='{{.Config.Image}}'", containerid ],quiet: true).trim();
    }

    UnmodifiableListView<String> get names {
        final List<String> names = new List<String>();

        _containerList.forEach((final String containerid) => names.add(Container.toName(containerid)));

        return new UnmodifiableListView<String>(names);
    }

    UnmodifiableListView<String> get images {
        final List<String> images = new List<String>();

        _containerList.forEach((final String containerid) => images.add(Container.toImage(containerid)));

        return new UnmodifiableListView<String>(images);
    }
}
