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
        Schema::create('blood_bags', function (Blueprint $table) {
            $table->id();
            
            // The required Foreign Key linking this bag to a specific refrigerator
            $table->foreignId('refrigerator_id')->constrained()->cascadeOnDelete();

            // Your accurately mapped fields
            $table->string('bag_number', 50)->unique();
            $table->string('blood_group', 10);
            $table->string('donor_name', 100);
            $table->date('collection_date');
            $table->date('expiry_date');
            $table->integer('quantity_ml');
            $table->enum('status', ['Available', 'Reserved', 'Dispatched', 'Expired'])->default('Available');
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('blood_bags');
    }
};