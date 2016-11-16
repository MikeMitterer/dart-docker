import 'package:grinder/grinder.dart';

main(final List<String> args) => grind(args);

@Task()
@Depends(test)
build() {
}

@Task()
@Depends(analyze,testUnit,testIntegration)
test() {
}

@Task()
testUnit() {
    new TestRunner().testAsync(files: "test/unit");

    // All tests with @TestOn("content-shell") in header
    // new TestRunner().test(files: "test/unit",platformSelector: "content-shell");
}

@Task()
testIntegration() {
    new TestRunner().testAsync(files: "test/integration");

    // All tests with @TestOn("content-shell") in header
    // new TestRunner().test(files: "test/integration",platformSelector: "content-shell");
}

@Task()
analyze() {
    final List<String> libs = [
        "lib/docker.dart",
        "lib/mock.dart"
    ];

    libs.forEach((final String lib) => Analyzer.analyze(lib));
    Analyzer.analyze("test");
}

@Task()
clean() => defaultClean();
