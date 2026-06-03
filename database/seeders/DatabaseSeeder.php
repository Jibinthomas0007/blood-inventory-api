<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\BloodBank;
use App\Models\Refrigerator;
use App\Models\BloodBag;
use App\Models\TemperatureLog;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Create the specific User Roles required by the assessment
        $admin = User::create([
            'name' => 'Admin Manager',
            'email' => 'admin@example.com',
            'password' => Hash::make('password123'),
            'role' => 'admin',
        ]);

        $staff = User::create([
            'name' => 'Staff Member',
            'email' => 'staff@example.com',
            'password' => Hash::make('password123'),
            'role' => 'staff',
        ]);

        $monitor = User::create([
            'name' => 'System Monitor',
            'email' => 'monitor@example.com',
            'password' => Hash::make('password123'),
            'role' => 'monitor',
        ]);

        // 2. Create a Central Blood Bank
        $bloodBank = BloodBank::create([
            'name' => 'City General Blood Bank',
            'location' => 'Downtown Medical Wing',
        ]);

        // 3. Attach the Users to the Blood Bank (Many-to-Many Pivot)
        $bloodBank->users()->attach([$admin->id, $staff->id, $monitor->id]);

        // 4. Create Refrigerators linked to the Blood Bank
        $fridgeA = Refrigerator::create([
            'blood_bank_id' => $bloodBank->id,
            'identifier' => 'Fridge-Alpha',
        ]);

        $fridgeB = Refrigerator::create([
            'blood_bank_id' => $bloodBank->id,
            'identifier' => 'Fridge-Beta',
        ]);

        // 5. Create Blood Bags (Including an expired one for testing later)
        BloodBag::create([
            'refrigerator_id' => $fridgeA->id,
            'bag_number' => 'BAG-1001',
            'blood_group' => 'O+',
            'donor_name' => 'John Doe',
            'collection_date' => Carbon::now()->subDays(5),
            'expiry_date' => Carbon::now()->addDays(37), // Valid bag
            'quantity_ml' => 450,
            'status' => 'Available',
        ]);

        BloodBag::create([
            'refrigerator_id' => $fridgeA->id,
            'bag_number' => 'BAG-1002',
            'blood_group' => 'A-',
            'donor_name' => 'Jane Smith',
            'collection_date' => Carbon::now()->subDays(50),
            'expiry_date' => Carbon::now()->subDays(5), // Already Expired
            'quantity_ml' => 450,
            'status' => 'Expired',
        ]);

        BloodBag::create([
            'refrigerator_id' => $fridgeB->id,
            'bag_number' => 'BAG-1003',
            'blood_group' => 'B+',
            'donor_name' => 'Mike Johnson',
            'collection_date' => Carbon::now()->subDays(2),
            'expiry_date' => Carbon::now()->addDays(40),
            'quantity_ml' => 450,
            'status' => 'Reserved',
        ]);

        // 6. Generate 15 minutes of dummy temperature logs for Fridge A
        for ($i = 0; $i < 15; $i++) {
            TemperatureLog::create([
                'refrigerator_id' => $fridgeA->id,
                // Generates temperatures between 4.0 and 8.5 to test your risk logic later
                'temperature' => rand(40, 85) / 10, 
                'created_at' => Carbon::now()->subMinutes(15 - $i),
            ]);
        }
    }
}