run: build deploy

visualize:
	cargo run --bin tree-visualizer --no-default-features

build:
	cross build \
		--package tree-writer \
		--release \
		--target armv7-unknown-linux-gnueabihf

frontend:
	(cd tree-frontend \
	&& trunk serve --proxy-backend=http://localhost:3030/ --proxy-rewrite=/api/)

backend:
	(cd tree-backend \
	&& RUST_LOG=debug cargo run)

frontend-release:
	(cd tree-frontend \
	&& trunk build --release)

setup-web:
	rustup target add wasm32-unknown-unknown
	cargo install trunk wasm-bindgen-cli

deploy:
	scp target/armv7-unknown-linux-gnueabihf/release/writerbin tree:~/rusty-tree
