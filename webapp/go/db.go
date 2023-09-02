package main

import (
	"fmt"

	"github.com/XSAM/otelsql"
	"github.com/jmoiron/sqlx"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"

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

	db, err := otelsql.Open(
		"pgx-replaced",
		dsn,
		otelsql.WithAttributes(
			semconv.DBSystemPostgreSQL,
		),
		otelsql.WithSpanOptions(otelsql.SpanOptions{
			Ping:                 false,
			RowsNext:             false,
			DisableErrSkip:       false,
			DisableQuery:         false,
			OmitConnResetSession: true,
			OmitConnPrepare:      true,
			OmitConnQuery:        false,
			OmitRows:             true,
			OmitConnectorConnect: false,
		}),
	)
	if err != nil {
		return nil, err
	}

	return sqlx.NewDb(db, "pgx"), nil
}
