const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("math", "src/main.zig", b.version(0, 0, 0));
    lib.setBuildMode(mode);
    lib.setTarget(.{ .cpu_arch = .wasm32, .os_tag = .freestanding });
    lib.install();

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
