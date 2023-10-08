use log::*;
use esp_idf_sys as _;

fn main() {
    esp_idf_sys::link_patches();
    esp_idf_svc::log::EspLogger::initialize_default();

    // Code starts here
    info!("Hello, world!");
}
