use std::os::raw::c_char;
use std::ffi::{CStr, CString};

use mrml;

fn to_string(unsafe_string: *const c_char) -> String {
  unsafe { CStr::from_ptr(unsafe_string) }.to_str().unwrap().to_string()
}

fn to_char(string: String) -> *mut c_char {
  CString::new(string).unwrap().into_raw()
}

#[no_mangle]
pub extern "C" fn to_title(input: *const c_char) -> *mut c_char {
  match mrml::to_title(&to_string(input), mrml::Options::default()) {
    Ok(html) => return to_char(html),
    Err(err) => return to_char(format!("Error: {:?}", err)),
  }
}

#[no_mangle]
pub extern "C" fn to_preview(input: *const c_char) -> *mut c_char {
  match mrml::to_preview(&to_string(input), mrml::Options::default()) {
    Ok(html) => return to_char(html),
    Err(err) => return to_char(format!("Error: {:?}", err)),
  }
}

#[no_mangle]
pub extern "C" fn to_html(input: *const c_char) -> *mut c_char {
  match mrml::to_html(&to_string(input), mrml::Options::default()) {
    Ok(html) => return to_char(html),
    Err(err) => return to_char(format!("Error: {:?}", err)),
  }
}

#[no_mangle]
pub extern "C" fn free_result(string: *mut c_char) {
  unsafe {
    if string.is_null() { return }
    CString::from_raw(string)
  };
}
