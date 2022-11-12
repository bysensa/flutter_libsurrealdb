// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

/**
 * Surrealdb part
 */
typedef struct SurrealSession SurrealSession;

char *rust_greeting(const char *to);

void rust_cstr_free(char *s);

struct SurrealSession *session_for_kv_new(void);

struct SurrealSession *session_for_ns_new(const char *ns);

struct SurrealSession *session_for_db_new(const char *ns, const char *db);

struct SurrealSession *session_for_sc_new(const char *ns, const char *db, const char *sc);

struct SurrealSession *session_set_with_ns(struct SurrealSession *ptr, const char *ns);

struct SurrealSession *session_set_with_db(struct SurrealSession *ptr, const char *db);

void session_free(struct SurrealSession *ptr);
