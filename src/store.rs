use surrealdb::Datastore;
use tokio::runtime::{Builder, Runtime};
use anyhow::Result;

pub struct SurrealDataStore {
    raw_rt: Runtime,
    raw_datastore: Datastore,
}

impl SurrealDataStore {
    pub fn memory() -> Result<Self> {
        let rt = Builder::new_multi_thread().build()?;
        let ds = rt.block_on(async {
            Datastore::new("memory").await
        });
        let ds = ds?;
        Ok(SurrealDataStore{raw_rt: rt, raw_datastore: ds})
    }
}