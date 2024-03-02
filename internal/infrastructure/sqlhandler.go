package infrastructure

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

type SqlHandler struct {
	Conn *sql.DB
}

func NewSqlHandler() (*SqlHandler, error) {
	// 環境変数からデータベース接続情報を取得
	dbUser := os.Getenv("DB_USER")
	dbPass := os.Getenv("DB_PASS")
	dbName := os.Getenv("DB_NAME")
	dbHost := os.Getenv("DB_HOST")

	// データベースに接続のための接続文字列を生成
	connStr := fmt.Sprintf("host=%s user=%s password=%s dbname=%s sslmode=disable", dbHost, dbUser, dbPass, dbName)

	// データベースへの接続を開く
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}

	return &SqlHandler{Conn: db}, nil
}
