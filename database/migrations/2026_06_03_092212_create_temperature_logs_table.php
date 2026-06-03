<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('temperature_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('refrigerator_id')->constrained()->cascadeOnDelete();
            $table->decimal('temperature', 5, 2); // e.g., 6.50
            $table->timestamps(); // The 'created_at' column acts as our exact minute timestamp
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('temperature_logs');
    }
};
