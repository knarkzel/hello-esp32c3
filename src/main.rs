use esp_idf_sys as _;

fn main() {
    esp_idf_sys::link_patches();
    println!("Hello, world!");
}
