use std::os::raw::c_char;
use std::ffi::{CStr, CString};

use mrml;

fn to_string(unsafe_string: *const c_char) -> String {
  unsafe { CStr::from_ptr(unsafe_string) }.to_str().unwrap().to_string()
}

fn to_char(string: String) -> *mut c_char {
  CString::new(string).unwrap().into_raw()
}

fn parse_result(result: Result<String, mrml::prelude::render::Error>) -> *mut c_char {
  if result.is_err() {
    to_char(format!("MRML::Error {:?}", result.unwrap_err()))
  } else {
    to_char(result.unwrap())
  }
}

fn parse_option(option: Option<String>) -> *mut c_char {
  to_char(option.unwrap_or("".to_string()))
}

#[no_mangle]
pub extern "C" fn to_title(input: *const c_char) -> *mut c_char {
  let root = mrml::parse(&to_string(input));

  if root.is_err() {
    to_char(format!("MRML::Error {:?}", root.unwrap_err()))
  } else {
    parse_option(root.unwrap().get_title())
  }
}

#[no_mangle]
pub extern "C" fn to_preview(input: *const c_char) -> *mut c_char {
  let root = mrml::parse(&to_string(input));

  if root.is_err() {
    to_char(format!("MRML::Error {:?}", root.unwrap_err()))
  } else {
    parse_option(root.unwrap().get_preview())
  }
}

#[no_mangle]
pub extern "C" fn to_html(input: *const c_char) -> *mut c_char {
  let root = mrml::parse(&to_string(input));
  let opts = mrml::prelude::render::Options::default();

  if root.is_err() {
    to_char(format!("MRML::Error {:?}", root.unwrap_err()))
  } else {
    parse_result(root.unwrap().render(&opts))
  }
}

#[no_mangle]
pub extern "C" fn free_result(string: *mut c_char) {
  unsafe {
    if string.is_null() { return }
    CString::from_raw(string)
  };
}
