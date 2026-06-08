<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Carbon\Carbon;

class Refrigerator extends Model
{
    protected $fillable = ['blood_bank_id', 'identifier'];

    public function bloodBank(): BelongsTo
    {
        return $this->belongsTo(BloodBank::class);
    }

    public function bloodBags(): HasMany
    {
        return $this->hasMany(BloodBag::class);
    }

    public function temperatureLogs(): HasMany
    {
        return $this->hasMany(TemperatureLog::class);
    }

    /**
     * Calculate the daily risk metrics for this specific refrigerator.
     */
    public function getDailyRiskMetricsAttribute()
    {
        // Get today's temperature logs
        $logs = $this->temperatureLogs()->whereDate('created_at', Carbon::today())->get();

        $totalMinutes = $logs->count();

        // If there are no logs yet today, return zeroed data
        if ($totalMinutes === 0) {
            return [
                'average_temp' => 0,
                'highest_temp' => 0,
                'lowest_temp' => 0,
                'unsafe_minutes' => 0,
                'risk_percentage' => 0,
                'status' => 'Unknown'
            ];
        }

        // 1, 2 & 3: Calculate Avg, Max, and Min
        $averageTemp = round($logs->avg('temperature'), 2);
        $highestTemp = $logs->max('temperature');
        $lowestTemp = $logs->min('temperature');

        // 4: Calculate Total Unsafe Minutes (Below 2.0 or Above 6.0)
        // We use the filter() collection method to catch BOTH extremes
        $unsafeMinutes = $logs->filter(function ($log) {
            return $log->temperature < 2.0 || $log->temperature > 6.0;
        })->count();

        // 5: Calculate Risk Percentage using the required formula
        $riskPercentage = round(($unsafeMinutes / $totalMinutes) * 100, 2);

        // 6: Determine overall status based on both hot and cold conditions
        $status = 'Safe'; // Strictly 2.0 to 6.0 degrees
        
        if ($highestTemp > 8.0 || $lowestTemp < 0.0) {
            $status = 'Critical'; // Freezing or dangerously hot
        } elseif ($highestTemp > 6.0 || $lowestTemp < 2.0) {
            $status = 'Warning'; // Approaching danger zones
        }

        return [
            'average_temp' => $averageTemp,
            'highest_temp' => $highestTemp,
            'lowest_temp' => $lowestTemp,
            'unsafe_minutes' => $unsafeMinutes,
            'risk_percentage' => $riskPercentage,
            'status' => $status
        ];
    }
}
