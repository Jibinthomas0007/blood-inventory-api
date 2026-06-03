<?php

namespace App\Observers;

use App\Models\TemperatureLog;
use App\Events\CriticalTemperatureReached;
use Carbon\Carbon;

class TemperatureLogObserver
{
    public function created(TemperatureLog $temperatureLog): void
    {
        $refrigeratorId = $temperatureLog->refrigerator_id;
        $tenMinutesAgo = Carbon::now()->subMinutes(10);

        // Get all logs for this fridge from the last 10 minutes
        $recentLogs = TemperatureLog::where('refrigerator_id', $refrigeratorId)
            ->where('created_at', '>=', $tenMinutesAgo)
            ->get();

        // If there are at least 10 logs, and the LOWEST temperature in that batch is strictly greater than 8.0...
        if ($recentLogs->count() >= 10 && $recentLogs->min('temperature') > 8.0) {

            // Prevent spam: Check if an alert was already triggered in the last 10 minutes
            $recentAlert = \App\Models\AlertHistory::where('refrigerator_id', $refrigeratorId)
                ->where('created_at', '>=', $tenMinutesAgo)
                ->exists();

            if (!$recentAlert) {
                // Trigger the Event!
                event(new CriticalTemperatureReached($temperatureLog->refrigerator));
            }
        }
    }
}
