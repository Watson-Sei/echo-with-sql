package main

import (
	"log"

	"github.com/Watson-Sei/echo-with-sql/internal/infrastructure"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Echoインスタンスの作成
	e := echo.New()

	// ミドルウェアの設定
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// データベースの初期化
	sqlHandler, err := infrastructure.NewSqlHandler()
	if err != nil {
		log.Fatalf("Failed to connect to the database: %v", err)
	}

	e.Logger.Fatal(e.Start(":8080"))
	defer sqlHandler.Conn.Close()
}
