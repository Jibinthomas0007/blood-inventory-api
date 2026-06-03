<?php

namespace App\Listeners;

use App\Events\CriticalTemperatureReached;
use App\Models\AlertHistory;
use App\Models\User;
use App\Notifications\CriticalAlertNotification;

class StoreAndNotifyCriticalAlert
{
    public function handle(CriticalTemperatureReached $event): void
    {
        $refrigerator = $event->refrigerator;

        // 1. Store the alert history in the database
        AlertHistory::create([
            'refrigerator_id' => $refrigerator->id,
            'message' => 'Temperature exceeded 8°C for 10 consecutive minutes.',
            'recorded_temperature' => 8.1 // In a real app, pass the exact latest temp
        ]);

        // 2. Dispatch the notification to all Admin users via Queue
        $admins = User::where('role', 'admin')->get();

        foreach ($admins as $admin) {
            $admin->notify(new CriticalAlertNotification($refrigerator));
        }
    }
}
