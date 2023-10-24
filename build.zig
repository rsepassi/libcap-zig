const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const static_lib = b.addStaticLibrary(.{
        .name = "cap",
        .target = target,
        .optimize = optimize,
    });
    static_lib.addCSourceFiles(&c_sources, &[_][]const u8{});
    static_lib.addIncludePath(.{.path = "src/libcap/include" });
    static_lib.linkLibC();
    b.installArtifact(static_lib);

    const header = b.addInstallHeaderFile("src/libcap/include/sys/capability.h", "sys/capability.h");
    b.getInstallStep().dependOn(&header.step);
}

const c_sources = [_][]const u8 {
    "src/libcap/cap_alloc.c",
    "src/libcap/cap_extint.c",
    "src/libcap/cap_file.c",
    "src/libcap/cap_flag.c",
    "src/libcap/cap_proc.c",
    "src/libcap/cap_text.c",
};
