#!/bin/sh

git clone https://github.com/torvalds/linux.git --depth=1 --branch=v6.3-rc7
git -C linux apply ../0001-rust-hardcode-RUST_MODFILE-for-Compiler-Explorer.patch
make -C linux --jobs=16 ARCH=x86_64 LLVM=1 defconfig rust.config prepare

mkdir linux-out
cd linux
cp --parents \
    ./rust/*.rmeta \
    ./rust/*.so \
    ./include/generated/rustc_cfg \
    ./scripts/target.json \
    ../linux-out
cd ..
rm --recursive linux
mv linux-out linux
