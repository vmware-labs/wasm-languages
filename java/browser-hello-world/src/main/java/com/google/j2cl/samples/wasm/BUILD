# Sample for J2WASM copied from https://github.com/google/j2cl.
#
# Note that J2WASM is experimental and it is NOT production ready.
#
# It is mostly developed to help with the evolution of WASM GC specification and
# what is released externally here is minimal working version to provide .wat files
# for community experimentation and it doesn't reflect final workings of the product
# nor the WASM spec.

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
load(
    "@com_google_j2cl//build_defs:rules.bzl",
    "j2cl_application",
    "j2wasm_application",
    "j2wasm_library",
)

package(licenses = ["notice"])

# This is the bazel target that compiles our J2WASM library.
# Since J2WASM currently does global compilation this only serves as a way
# to collect sources and byte code required for j2wasm_application compilation.
j2wasm_library(
    name = "helloworld",
    srcs = glob(["*.java"]),
)

# This is the bazel target that compiles and optimizes whole J2WASM app.
# It provides couple of convenient targets:
#  :app produces the app.wat and app.wasm that could be used for production.
#  :app_dev produces app_dev.wat and app_dev.wasm as development version
#
# e.g.:
#   $ (cd j2cl; bazel build src/main/java/com/google/j2cl/samples/wasm:app)
#
# Note that for .wat files (wasm binary output) to be available, you would
# need to have a recent version of binaryen available in your path.
j2wasm_application(
    name = "app",
    entry_points = [r"com\.google\.j2cl\.samples\.wasm\.HelloWorld\.getHelloWorld"],
    deps = [":helloworld"],
)

# Below is an example of the JS wiring of the wasm app

closure_js_library(
    name = "hellojs",
    srcs = glob(["*.js"]),
    lenient = True,
    deps = ["@com_google_j2cl//:j2wasm_js"],
)

# This is the bazel target that serves your J2WASM app.
#
# Give it a try:
#   $ (cd j2cl; bazel run src/main/java/com/google/j2cl/samples/wasm:jsapp_dev_server)
#
# To launch the browser (use unstable):
#
# $ google-chrome-unstable --js-flags="--experimental-wasm-typed-funcref  --experimental-wasm-gc --experimental-wasm-eh"
#
j2cl_application(
    name = "jsapp",
    entry_points = ["entry"],
    extra_dev_resources = [
        ":app.wasm",
    ],
    deps = [":hellojs"],
    dev_server_port = "8000",
)
