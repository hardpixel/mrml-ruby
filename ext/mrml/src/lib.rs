use magnus::{
  class, define_module, function, method,
  prelude::*, gc::register_mark_object, memoize,
  Error, ExceptionClass, RModule
};

use mrml::mjml::Mjml;
use mrml::prelude::print::Printable;
use mrml::prelude::render::RenderOptions;

fn mrml_error() -> ExceptionClass {
  *memoize!(ExceptionClass: {
    let ex = class::object().const_get::<_, RModule>("MRML").unwrap().const_get("Error").unwrap();
    register_mark_object(ex);
    ex
  })
}

macro_rules! error {
  ($ex:ident) => {
    Error::new(mrml_error(), $ex.to_string())
  };
}

#[magnus::wrap(class = "MRML::Template", free_immediately, size)]
struct Template {
  res: Mjml
}

impl Template {
  fn new(input: String) -> Result<Self, Error> {
    match mrml::parse(&input) {
      Ok(res) => Ok(Self { res }),
      Err(ex) => Err(error!(ex))
    }
  }

  fn from_json(input: String) -> Result<Self, Error> {
    match serde_json::from_str::<Mjml>(&input) {
      Ok(res) => Ok(Self { res }),
      Err(ex) => Err(error!(ex))
    }
  }

  fn get_title(&self) -> Option<String> {
    self.res.get_title()
  }

  fn get_preview(&self) -> Option<String> {
    self.res.get_preview()
  }

  fn to_mjml(&self) -> String {
    self.res.print_dense().unwrap()
  }

  fn to_json(&self) -> Result<String, Error> {
    match serde_json::to_string(&self.res) {
      Ok(res) => Ok(res),
      Err(ex) => Err(error!(ex))
    }
  }

  fn to_html(&self) -> Result<String, Error> {
    match self.res.render(&RenderOptions::default()) {
      Ok(res) => Ok(res),
      Err(ex) => Err(error!(ex))
    }
  }
}

impl Clone for Template {
  fn clone(&self) -> Self {
    Self::new(self.to_mjml()).unwrap()
  }
}

#[magnus::init]
fn init() -> Result<(), Error> {
  let module = define_module("MRML")?;
  let class = module.define_class("Template", class::object())?;

  class.define_singleton_method("new", function!(Template::new, 1))?;
  class.define_singleton_method("from_json", function!(Template::from_json, 1))?;

  class.define_method("title", method!(Template::get_title, 0))?;
  class.define_method("preview", method!(Template::get_preview, 0))?;

  class.define_method("to_mjml", method!(Template::to_mjml, 0))?;
  class.define_method("to_json", method!(Template::to_json, 0))?;
  class.define_method("to_html", method!(Template::to_html, 0))?;

  class.define_method("clone", method!(Template::clone, 0))?;
  class.define_method("dup", method!(Template::clone, 0))?;

  Ok(())
}
