# AWS Lambda & Rust Deployment Method


<p float="left">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/mjehrhart/assets/main/images/Amazon_Lambda_architecture_logo.svg_BJlr5ojmmqIb7PH7.png" width="300" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/mjehrhart/assets/main/images/Moby-logo_lzPn2FhabJy0xWhh.webp" width="300" />  
</p>


# Prerequisite
This guide is written for macOS users. Make sure you have these following items installed and configured if needed. Installing these items takes only a few minutes. This guide will help you deploy rust lambdas into AWS using SAM CLI. Plus you can test locally using SAM CLI as well.

- AWS SAM CLI  
	https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html

- Docker - container for building cross compilation  
  https://docs.docker.com/get-started/  

- Artillery - used for rapid testing  
  ```npm install -g artillery@latest```

# Setup
Open your mac terminal to your projects home directory
- ```git clone https://github.com/mjehrhart/sam-rust-template.git``` or use ```sam init``` for a new install
- ```make setup``` (uses the Makefile from this repo)
- Make any changes to Makefile
- Make any changes to template.yaml  

Once all this is done, go ahead and do your coding stuff.  As of the time of writing this, various rust crates do not work in AWS lambda or at least I haven't been able to get them to work.  So be careful and take your time testing crates.  For me, it was a lot of trial and error.  

# Commands
Using Docker with SAM CLI is preferred for the build
- ```alias rust-musl-builder='docker run --rm -it -v "$(pwd)":/home/rust/src ekidd/rust-musl-builder'```
- ```rust-musl-builder cargo build --release```

Build
- ```make bootstrap``` or ```make bootstrap_debug```

Deploy to AWS
- ```make deploy```

# Testing Options
- ```make tests-unit```

- ```make tests-integ```
- ```sam local start-api``` (only restart server if changes to template.yaml are made )

Update Changes to test locally with SAM CLI
- ```rust-musl-builder cargo build --release``` (takes a few minutes)

- ```make bootstrap```
- open browser to http://127.0.0.1:3000
- SAM CLI will work off of the updated bootstrap file. That is why we update it here after any changes to the code.

# Cleanup
- ```sam delete```

# Helpful Links
- https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/building-custom-runtimes.html

- https://github.com/aws-samples/serverless-rust-demo

- https://github.com/awslabs/aws-lambda-rust-runtime/blob/main/lambda-http/examples/hello-http.rs
 

# Screenshots  

#### Makefile
Here is what my Makefile looks like. It works great for me.

<img width="50%" alt="images/Screen Shot 2022-05-11 at 10.04.38 AM_gOO0tQxBTQudo5Re.png" src="https://raw.githubusercontent.com/mjehrhart/assets/main/images/Screen Shot 2022-05-11 at 10.04.38 AM_gOO0tQxBTQudo5Re.png">

#### template.yaml
Note the CodeUri points to the build/ directory.  This is where the bootstrap file be put.  So the CodeUri points to the location of the bootstrap for that function.  

<img width="50%" alt="images/Screen Shot 2022-05-10 at 10.00.09 AM_NDCdNwvovL0Tjp0Y.png" src="https://raw.githubusercontent.com/mjehrhart/assets/main/images/Screen Shot 2022-05-10 at 10.00.09 AM_NDCdNwvovL0Tjp0Y.png">
