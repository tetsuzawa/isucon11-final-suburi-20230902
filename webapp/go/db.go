package main

import (
	"github.com/XSAM/otelsql"
	"github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"
)

func GetDB(batch bool) (*sqlx.DB, error) {
	mysqlConfig := mysql.NewConfig()
	mysqlConfig.Net = "tcp"
	mysqlConfig.Addr = GetEnv("MYSQL_HOSTNAME", "127.0.0.1") + ":" + GetEnv("MYSQL_PORT", "3306")
	mysqlConfig.User = GetEnv("MYSQL_USER", "isucon")
	mysqlConfig.Passwd = GetEnv("MYSQL_PASS", "isucon")
	mysqlConfig.DBName = GetEnv("MYSQL_DATABASE", "isucholar")
	mysqlConfig.Params = map[string]string{
		"time_zone": "'+00:00'",
	}
	mysqlConfig.ParseTime = true
	mysqlConfig.MultiStatements = batch

	db, err := otelsql.Open(
		"mysql",
		mysqlConfig.FormatDSN(),
		otelsql.WithAttributes(
			semconv.DBSystemMySQL,
		),
	)
	if err != nil {
		return nil, err
	}

	return sqlx.NewDb(db, "mysql"), nil
}
