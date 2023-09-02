package main

import (
	"fmt"

	"github.com/jmoiron/sqlx"
	_ "github.com/mackee/pgx-replaced"
)

func GetDB(batch bool) (*sqlx.DB, error) {
	dsn := fmt.Sprintf(
		"postgres://%s:%s@%s:%v/%s?sslmode=disable",
		GetEnv("PG_USER", "isucon"),
		GetEnv("PG_PASS", "isucon"),
		GetEnv("PG_HOSTNAME", "127.0.0.1"),
		GetEnv("PG_PORT", "5432"),
		GetEnv("PG_DATABASE", "isucholar"),
	)

	return sqlx.Open("pgx-replaced", dsn)
}
