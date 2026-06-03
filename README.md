# Smart Blood Inventory & Temperature Monitoring System

A scalable Laravel 11 backend API for managing blood bags, monitoring refrigerator temperatures, and tracking inventory traceability. 

## Setup Instructions
1. Clone the repository.
2. Run `composer install` to install PHP dependencies.
3. Copy `.env.example` to `.env` and configure your database settings (Recommended: `DB_COLLATION=utf8mb4_unicode_ci` for local XAMPP setups).
4. Run `php artisan key:generate`.
5. Run `php artisan migrate:fresh --seed` to build the database and populate test data.
6. Run `php artisan notifications:table` and `php artisan queue:table` (if not already migrated).
7. Start the local server: `php artisan serve`.
8. In a separate terminal, start the queue worker: `php artisan queue:work`.
9. Import the provided Postman collection to test the endpoints.

---

## Architecture & Scaling Discussion (Handling 10 Million Logs/Day)

To scale this system to handle 10 million temperature logs daily (~115 logs per second) while maintaining fast dashboard load times, the following architectural strategies would be implemented:

### 1. Database Indexing & Query Optimization
* **Indexing:** Composite indexes would be added to the `temperature_logs` table, specifically on `(refrigerator_id, created_at)` to optimize the time-series queries used in the risk analysis and dashboard APIs.
* **Eager Loading:** Strict adherence to Eloquent eager loading (`with()`) prevents N+1 query bottlenecks when retrieving nested relationships (e.g., Blood Banks -> Refrigerators -> Blood Bags).

### 2. Database Partitioning
* The `temperature_logs` table will grow exponentially. We would implement **Table Partitioning** by date (e.g., weekly or monthly partitions). This ensures that querying "today's logs" only scans a tiny fraction of the table, rather than millions of historical rows.

### 3. Read/Write Database Separation
* **Primary/Replica Setup:** All heavy write operations (incoming IoT temperature logs every minute) will be directed to a Master Database. Read-heavy operations (Dashboard APIs, Analytics) will be routed to Read Replicas to prevent table locking and ensure the UI remains blazing fast.

### 4. Redis Caching
* The `/api/dashboard/overview` endpoint calculates facility-wide metrics. Instead of querying the database on every page load, these results would be cached in **Redis** for 5–10 minutes. 
* Frequent static queries (like `BloodBag::where('status', 'Available')->count()`) would utilize Laravel's `Cache::remember()` method.

### 5. Queue Optimization
* The current `database` queue driver is excellent for development, but for enterprise scale, we would migrate to **Redis (Laravel Horizon)**. 
* Redis handles high-throughput background jobs strictly in memory, allowing us to process thousands of critical temperature alerts concurrently without overwhelming the MySQL database.

### 6. Failover & Storage Optimization
* **High Availability:** The API servers would sit behind a Load Balancer with auto-scaling groups. If a server fails, traffic is instantly rerouted.
* **Storage Archiving:** Temperature logs older than 90 days (which are no longer needed for immediate risk calculation) would be archived to cold storage (e.g., AWS S3) to keep the active database lean and performant.