use lambda_http::{service_fn, Body, Error, IntoResponse, Request, RequestExt, Response};
use std::env;

/// Main function
#[tokio::main]
async fn main() -> Result<(), Error> {
    lambda_http::run(service_fn(|request: Request| get_thing(request))).await?;

    Ok(())
}

async fn get_thing(request: Request) -> Result<impl IntoResponse, Error> {
    let config = aws_config::load_from_env().await;
    let s3_client = aws_sdk_s3::Client::new(&config);

    // let resp = s3_client
    //     .get_object()
    //     .bucket("test-repeaterbook")
    //     .key("california_repeaters.json")
    //     .send()
    //     .await;

    // let data = resp.unwrap().body.collect().await;
    // let res_data = data.unwrap().into_bytes().slice(0..35);
    // let json_str = std::str::from_utf8(&res_data).unwrap().to_string();

    // Ok(Response::builder()
    //     .status(200)
    //     .body("Today is still Tuesday, one day before Wednesday")?)
    Ok(Response::builder().status(200).body("Happy Night Day")?)
}
 