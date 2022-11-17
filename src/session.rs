use surrealdb::Session;

pub struct SurrealSession {
    session: Session,
}

impl SurrealSession {

    pub fn for_kv() -> Self {
        SurrealSession {session: Session::for_kv() }
    }

    pub fn for_ns<S>(ns: S) -> Self
        where S: Into<String> + Clone, {
        SurrealSession {session: Session::for_ns(ns) }
    }

    pub fn for_db<S>(ns: S, db: S) -> Self
        where S: Into<String> + Clone, {
        SurrealSession {session: Session::for_db(ns, db) }
    }

    pub fn for_sc<S>(ns: S, db: S, sc: S) -> Self
        where S: Into<String> + Clone, {
        SurrealSession {session: Session::for_sc(ns, db, sc) }
    }

    pub fn with_ns(mut self, ns: &str) -> Self {
        self.session = self.session.with_ns(ns);
        self
    }

    pub fn with_db(mut self, db: &str) -> Self {
        self.session = self.session.with_db(db);
        self
    }
}