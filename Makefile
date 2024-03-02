# Makefile

# マイグレーションファイルが存在するディレクトリ
MIGRATIONS_DIR = db/migrations 

# PostgreSQL接続情報
POSTGRES_URL = postgresql://root:12345@db/master?sslmode=disable

# マイグレーションファイル作成
migration-create:
	migrate create -ext sql -dir db/migrations -seq $(name)

# マイグレーション実行
migrate-up:
	migrate -path $(MIGRATIONS_DIR) -database $(POSTGRES_URL) up

# マイグレーションロールバック
migrate-down:
	migrate -path $(MIGRATIONS_DIR) -database $(POSTGRES_URL) down

# 特定のバージョンへのマイグレーション
migrate-to:
	migrate -path $(MIGRATIONS_DIR) -database $(POSTGRES_URL) goto $(version)

# マイグレーションの強制実行
migrate-force:
	migrate -path $(MIGRATIONS_DIR) -database $(POSTGRES_URL) force $(version)

# ショートカット
.PHONY: migrate-up migrate-down migrate-to migrate-force