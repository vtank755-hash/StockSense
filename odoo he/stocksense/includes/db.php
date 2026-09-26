<?php
/**
 * StockSense - Database Helper Class
 * Provides convenient wrappers around PDO for common database operations
 */

class Database {
    private $pdo;

    public function __construct(PDO $pdo) {
        $this->pdo = $pdo;
    }

    /**
     * Get the raw PDO instance
     */
    public function getPdo(): PDO {
        return $this->pdo;
    }

    /**
     * Execute a query and return the statement
     */
    public function query(string $sql, array $params = []): PDOStatement {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    /**
     * Fetch a single row
     */
    public function fetch(string $sql, array $params = []): ?array {
        $stmt = $this->query($sql, $params);
        $result = $stmt->fetch();
        return $result ?: null;
    }

    /**
     * Fetch all rows
     */
    public function fetchAll(string $sql, array $params = []): array {
        $stmt = $this->query($sql, $params);
        return $stmt->fetchAll();
    }

    /**
     * Fetch a single column value
     */
    public function fetchColumn(string $sql, array $params = []) {
        $stmt = $this->query($sql, $params);
        return $stmt->fetchColumn();
    }

    /**
     * Insert a row and return the last insert ID
     */
    public function insert(string $table, array $data): int {
        $columns = implode(', ', array_keys($data));
        $placeholders = implode(', ', array_fill(0, count($data), '?'));
        $sql = "INSERT INTO {$table} ({$columns}) VALUES ({$placeholders})";
        $this->query($sql, array_values($data));
        return (int)$this->pdo->lastInsertId();
    }

    /**
     * Update rows matching conditions
     */
    public function update(string $table, array $data, string $where, array $whereParams = []): int {
        $setParts = [];
        $values = [];
        foreach ($data as $column => $value) {
            $setParts[] = "{$column} = ?";
            $values[] = $value;
        }
        $setString = implode(', ', $setParts);
        $sql = "UPDATE {$table} SET {$setString} WHERE {$where}";
        $values = array_merge($values, $whereParams);
        $stmt = $this->query($sql, $values);
        return $stmt->rowCount();
    }

    /**
     * Delete rows matching conditions
     */
    public function delete(string $table, string $where, array $params = []): int {
        $sql = "DELETE FROM {$table} WHERE {$where}";
        $stmt = $this->query($sql, $params);
        return $stmt->rowCount();
    }

    /**
     * Count rows matching conditions
     */
    public function count(string $table, string $where = '1=1', array $params = []): int {
        $sql = "SELECT COUNT(*) FROM {$table} WHERE {$where}";
        return (int)$this->fetchColumn($sql, $params);
    }

    /**
     * Begin a transaction
     */
    public function beginTransaction(): bool {
        return $this->pdo->beginTransaction();
    }

    /**
     * Commit a transaction
     */
    public function commit(): bool {
        return $this->pdo->commit();
    }

    /**
     * Rollback a transaction
     */
    public function rollback(): bool {
        return $this->pdo->rollBack();
    }

    /**
     * Get last insert ID
     */
    public function lastInsertId(): string {
        return $this->pdo->lastInsertId();
    }

    /**
     * Generate next reference code (e.g., REC-2026-006)
     */
    public function generateReference(string $prefix, string $table): string {
        $year = date('Y');
        $pattern = $prefix . '-' . $year . '-%';
        $sql = "SELECT reference FROM {$table} WHERE reference LIKE ? ORDER BY id DESC LIMIT 1";
        $last = $this->fetchColumn($sql, [$pattern]);
        
        if ($last) {
            $parts = explode('-', $last);
            $num = (int)end($parts) + 1;
        } else {
            $num = 1;
        }
        
        return $prefix . '-' . $year . '-' . str_pad($num, 3, '0', STR_PAD_LEFT);
    }
}
