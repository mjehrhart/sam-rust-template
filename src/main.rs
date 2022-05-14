use lambda_http::{service_fn, Body, Error, IntoResponse, Request, RequestExt, Response};
use std::env;

/// Main function
#[tokio::main]
async fn main() -> Result<(), Error> {
    lambda_http::run(service_fn(|request: Request| do_something(request))).await?;

    Ok(())
}

async fn do_something(request: Request) -> Result<impl IntoResponse, Error> {
 
    Ok(Response::builder().status(200).body("Happy Night Day")?)
}
 