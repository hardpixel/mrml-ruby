use magnus::{
  class, define_module, function, method,
  prelude::*, gc::register_mark_object, memoize,
  Error, ExceptionClass, RClass, RModule
};

use mrml::mjml::MJML;
use mrml::prelude::print::Print;
use mrml::prelude::render::Options;

fn mrml_error() -> ExceptionClass {
  *memoize!(ExceptionClass: {
    let ex: RClass = class::object().const_get::<_, RModule>("MRML").unwrap().const_get("Error").unwrap();
    register_mark_object(ex);

    ExceptionClass::from_value(*ex).unwrap()
  })
}

#[magnus::wrap(class = "MRML::Template", free_immediatly, size)]
struct Template {
  res: MJML
}

impl Template {
  fn new(input: String) -> Result<Self, Error> {
    match mrml::parse(&input) {
      Ok(res) => Ok(Self { res }),
      Err(ex) => Err(Error::new(mrml_error(), ex.to_string()))
    }
  }

  fn from_json(input: String) -> Result<Self, Error> {
    match serde_json::from_str::<MJML>(&input) {
      Ok(res) => Ok(Self { res }),
      Err(ex) => Err(Error::new(mrml_error(), ex.to_string()))
    }
  }

  fn get_title(&self) -> Option<String> {
    self.res.get_title()
  }

  fn get_preview(&self) -> Option<String> {
    self.res.get_preview()
  }

  fn to_mjml(&self) -> String {
    self.res.dense_print()
  }

  fn to_json(&self) -> Result<String, Error> {
    match serde_json::to_string(&self.res) {
      Ok(res) => Ok(res),
      Err(ex) => Err(Error::new(mrml_error(), ex.to_string()))
    }
  }

  fn to_html(&self) -> Result<String, Error> {
    match self.res.render(&Options::default()) {
      Ok(res) => Ok(res),
      Err(ex) => Err(Error::new(mrml_error(), ex.to_string()))
    }
  }
}

#[magnus::init]
fn init() -> Result<(), Error> {
  let module = define_module("MRML")?;
  let class = module.define_class("Template", Default::default())?;

  class.define_singleton_method("new", function!(Template::new, 1))?;
  class.define_singleton_method("from_json", function!(Template::from_json, 1))?;

  class.define_method("title", method!(Template::get_title, 0))?;
  class.define_method("preview", method!(Template::get_preview, 0))?;

  class.define_method("to_mjml", method!(Template::to_mjml, 0))?;
  class.define_method("to_json", method!(Template::to_json, 0))?;
  class.define_method("to_html", method!(Template::to_html, 0))?;

  Ok(())
}
