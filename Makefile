STACK_NAME ?= stack-sam-rust-test10
NAME ?= sam-rust-test10
# FUNCTIONS := get-thing

ARCH := aarch64-unknown-linux-gnu
ARCH_SPLIT = $(subst -, ,$(ARCH))

.PHONY: build deploy tests

# all: build tests-unit deploy tests-integ
# ci: build tests-unit

setup:
	mkdir build
ifeq (,$(shell which rustc))
	$(error "Could not found Rust compiler, please install it")
endif
ifeq (,$(shell which cargo))
	$(error "Could not found Cargo, please install it")
endif
# ifeq (,$(shell which cargo-lambda))
# 	$(error "Could not found cargo-lambda, please install it")
# 	cargo install cargo-lambda
# endif 
ifeq (,$(shell which sam))
	$(error "Could not found SAM CLI, please install it")
endif
ifeq (,$(shell which artillery))
	$(error "Could not found Artillery, it's required for load testing")
endif

bootstrap:
	cp ./target/x86_64-unknown-linux-musl/release/$(NAME) ./build/bootstrap 
 
bootstrap_debug:
	cp ./target/x86_64-unknown-linux-musl/debug/$(NAME) ./build/bootstrap 
 

# TODO - i think this is not needed since i user docker
# build:
# 	cargo lambda build --release --target $(ARCH)

deploy:
	if [ -f samconfig.toml ]; \
		then sam deploy --stack-name $(STACK_NAME); \
		else sam deploy -g --stack-name $(STACK_NAME); \
	fi

tests-unit:
	cargo test --lib --bins

tests-integ:
	RUST_BACKTRACE=1 API_URL=$$(aws cloudformation describe-stacks --stack-name $(STACK_NAME) \
		--query 'Stacks[0].Outputs[?OutputKey==`ApiUrl`].OutputValue' \
		--output text) cargo test

tests-load:
	API_URL=$$(aws cloudformation describe-stacks --stack-name $(STACK_NAME) \
		--query 'Stacks[0].Outputs[?OutputKey==`ApiUrl`].OutputValue' \
		--output text) artillery run tests/load-test.yml
 