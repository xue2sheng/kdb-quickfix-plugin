#![allow(non_snake_case)]
use kdbplus::qtype;
use kdbplus::api::*;

#[no_mangle]
pub extern "C" fn symbol_list(_: K) -> K{
  let mut list=new_list(qtype::SYMBOL_LIST, 0);
  list.push_symbol("Abraham").unwrap();
  list.push_symbol("Isaac").unwrap();
  list.push_symbol("Jacob").unwrap();
  list.push_symbol_n("Josephine", 6).unwrap();
  list
}
