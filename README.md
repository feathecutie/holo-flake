## Investigation of build failure of holo-northbound

```
this derivation will be built:
  /nix/store/5j4hhchgalnshr1rvc908fkxwr63h7cf-holo-0.5.0.drv
building '/nix/store/5j4hhchgalnshr1rvc908fkxwr63h7cf-holo-0.5.0.drv'...
error: builder for '/nix/store/5j4hhchgalnshr1rvc908fkxwr63h7cf-holo-0.5.0.drv' failed with exit code 101;
       last 25 log lines:
       >    Compiling tracing-subscriber v0.3.18
       > error: failed to run custom build command for `holo-northbound v0.5.0 (/build/source/holo-northbound)`
       >
       > Caused by:
       >   process didn't exit successfully: `/build/source/target/release/build/holo-northbound-c94e680fcb7d8d1b/build-script-build` (exit status: 101)
       >   --- stderr
       >   thread 'main' panicked at holo-northbound/build.rs:460:35:
       >   Unknown leaf type
       >   stack backtrace:
       >      0: rust_begin_unwind
       >      1: core::panicking::panic_fmt
       >      2: build_script_build::leaf_type_map
       >                at ./build.rs:460:35
       >      3: build_script_build::StructBuilder::generate
       >                at ./build.rs:180:38
       >      4: build_script_build::generate_module
       >                at ./build.rs:549:17
       >      5: build_script_build::generate_module
       >                at ./build.rs:567:9
       >      6: build_script_build::main
       >                at ./build.rs:675:9
       >      7: core::ops::function::FnOnce::call_once
       >                at /build/rustc-1.80.1-src/library/core/src/ops/function.rs:250:5
       >   note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
       > warning: build failed, waiting for other jobs to finish...
       For full logs, run 'nix log /nix/store/5j4hhchgalnshr1rvc908fkxwr63h7cf-holo-0.5.0.drv'.
```

Assumption:
- `generate_module` is called on invalid modules
- <- `yang::load_module` returns invalid module
- <- `ctx.load_module` returns invalid module (but in an `Ok`)
- <- `ffi::ly_ctx_load_module` returns an incorrect module (but not `NULL`)

### TODO:

- [] Figure out what the "searchpath" is (where libyang looks for modules)
