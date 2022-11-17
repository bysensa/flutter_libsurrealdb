mod session;
mod store;

use std::os::raw::{c_char};
use std::ffi::{CString, CStr};
use std::ops::Deref;
use lazy_static::lazy_static;
use serde_json::json;
use surrealdb::{Datastore, Session};
use tokio::runtime::{Runtime, Builder};
use crate::session::SurrealSession;
use crate::store::SurrealDataStore;

type Database = (Runtime, Datastore, Session);

lazy_static! {
    static ref DB: Database = {
        let rt = Builder::new_multi_thread().build().unwrap();
        let ds = rt.block_on(async {
            Datastore::new("memory").await.unwrap()
        });
        let ses = Session::for_kv();
        (rt, ds, ses)
    };
}

#[no_mangle]
pub extern fn rust_greeting(to: *const c_char) -> *mut c_char {
    let c_str = unsafe { CStr::from_ptr(to) };
    let query = match c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };

    let (rt, ds, ses) = DB.deref();
    let res = rt.block_on(async move {
        let ast = query;
        ds.execute(ast, &ses, None, false).await
    });

    let res_json = res.map_or(
        json!({"error": "Something went wrong"}).to_string(),
        |val | serde_json::to_string(&val).unwrap_or(json!({"error": "Serialization failed"}).to_string()));
    // let res_json = match res {
    //     Ok(val) => serde_json::to_string(&val),
    //     Err(_) => {}
    // };

    CString::new(res_json).unwrap().into_raw()
}

#[no_mangle]
pub extern fn rust_cstr_free(s: *mut c_char) {
    unsafe {
        if s.is_null() { return }
        CString::from_raw(s)
    };
}



// Surreal Session
#[no_mangle]
pub extern "C" fn session_for_kv_new() -> *mut SurrealSession {
    Box::into_raw(Box::new(SurrealSession::for_kv()))
}

#[no_mangle]
pub extern "C" fn session_for_ns_new(ns: *const c_char) -> *mut SurrealSession {
    let c_str = unsafe { CStr::from_ptr(ns) };
    let ns = match c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    Box::into_raw(Box::new(SurrealSession::for_ns(ns)))
}

#[no_mangle]
pub extern "C" fn session_for_db_new(ns: *const c_char, db: *const c_char) -> *mut SurrealSession {
    let ns_str = unsafe { CStr::from_ptr(ns) };
    let db_str = unsafe { CStr::from_ptr(db) };
    let ns = match ns_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let db = match db_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    Box::into_raw(Box::new(SurrealSession::for_db(ns, db)))
}

#[no_mangle]
pub extern "C" fn session_for_sc_new(ns: *const c_char, db: *const c_char, sc: *const c_char) -> *mut SurrealSession {
    let ns_str = unsafe { CStr::from_ptr(ns) };
    let db_str = unsafe { CStr::from_ptr(db) };
    let sc_str = unsafe { CStr::from_ptr(sc) };
    let ns = match ns_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let db = match db_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let sc = match sc_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    Box::into_raw(Box::new(SurrealSession::for_sc(ns, db, sc)))
}

#[no_mangle]
pub extern "C" fn session_set_with_ns(ptr: *mut SurrealSession, ns: *const c_char)  -> *mut SurrealSession  {
    let session = unsafe {
        assert!(!ptr.is_null());
        Box::from_raw(ptr)
    };
    let c_str = unsafe { CStr::from_ptr(ns) };
    let ns = match c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    Box::into_raw(Box::new(session.with_ns(ns)))
}

#[no_mangle]
pub extern "C" fn session_set_with_db(ptr: *mut SurrealSession, db: *const c_char)  -> *mut SurrealSession  {
    let session = unsafe {
        assert!(!ptr.is_null());
        Box::from_raw(ptr)
    };
    let c_str = unsafe { CStr::from_ptr(db) };
    let db = match c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    Box::into_raw(Box::new(session.with_db(db)))
}

#[no_mangle]
pub extern "C" fn session_free(ptr: *mut SurrealSession) {
    if ptr.is_null() {
        return;
    }
    unsafe {
        let _ = Box::from_raw(ptr);
    }
}

// // Surreal Datastore
// #[no_mangle]
// pub extern "C" fn datastore_memory_new() -> *mut SurrealDataStore {
//     let ds = SurrealDataStore::memory();
//     match ds {
//         Ok(ds) => Box::into_raw(Box::new(ds)),
//         Err(_) => {}
//     }
// }
//
// #[no_mangle]
// pub extern "C" fn datastore_free(ptr: *mut SurrealDataStore) {
//     if ptr.is_null() {
//         return;
//     }
//     unsafe {
//         let _ = Box::from_raw(ptr);
//     }
// }