let path = "Cargo.toml";
let type = variable::get("crate_type");

let var_project_name = variable::get("project-name");
let var_project_description = variable::get("project-description");
let var_gh_username = variable::get("gh-username");
let var_rust_version = variable::get("rust-version");

let _lib = `
[lib]
doctest = false
`;

let _bin = `
[[bin]]
name = "${var_project_name}"
path = "src/main.rs"
`;

let pkg = switch type {
    "lib" => _lib,
    "bin" => _bin,
    _ => {}
};

pkg.trim();
print(pkg);

let _toml = `
[package]
name = "${var_project_name}"
version.workspace = true
edition.workspace = true
description.workspace = true
license.workspace = true
homepage.workspace = true
documentation.workspace = true
repository.workspace = true
rust-version.workspace = true

[workspace]
members = []

[workspace.package]
version = "0.1.0"
edition = "2024"
description = "${var_project_description}"
license = "GPL-3.0-only"
homepage = "https://github.com/${var_gh_username}/${var_project_name}"
documentation = "https://github.com/${var_gh_username}/${var_project_name}"
repository = "https://github.com/${var_gh_username}/${var_project_name}"
rust-version = "${var_rust_version}"
publish = false

${pkg}

[lints]
workspace = true

[profile.release]
lto = "fat"
opt-level = 3
codegen-units = 1

[profile.dev]
debug = 0

[features]
default = []

[dependencies]

[workspace.lints.clippy]
cast_lossless = "deny"
complexity = { level = "deny", priority = -1 }
correctness = { level = "deny", priority = -1 }
dbg_macro = "deny"
explicit_into_iter_loop = "deny"
explicit_iter_loop = "deny"
get_first = "deny"
implicit_clone = "deny"
indexing_slicing = "deny"
inefficient_to_string = "deny"
items-after-statements = "deny"
manual_string_new = "deny"
needless_collect = "deny"
perf = { level = "deny", priority = -1 }
redundant_closure_for_method_calls = "deny"
style = { level = "deny", priority = -1 }
suspicious = { level = "deny", priority = -1 }
uninlined_format_args = "allow"
unused_self = "deny"
unwrap_used = "deny"
unimplemented = "deny"
unused_async = "deny"
map_err_ignore = "deny"
expect_used = "deny"
as_conversions = "deny"
`;

file::write(path, _toml);
