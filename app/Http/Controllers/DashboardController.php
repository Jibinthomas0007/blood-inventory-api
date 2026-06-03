<?php

namespace App\Http\Controllers;

use App\Models\BloodBag;
use App\Models\Refrigerator;
use App\Models\TemperatureLog;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    /**
     * Get the main dashboard overview metrics.
     */
    public function getOverview()
    {
        $today = Carbon::today();

        // 1. Total blood bags
        $totalBags = BloodBag::count();

        // 2. Available stock by blood group
        $stockByGroup = BloodBag::where('status', 'Available')
            ->select('blood_group', DB::raw('count(*) as count'))
            ->groupBy('blood_group')
            ->get();

        // 3. Total expired bags
        $totalExpired = BloodBag::where('status', 'Expired')
            ->orWhereDate('expiry_date', '<', $today)
            ->count();

        // 4. Average temperature for today
        $averageTemp = TemperatureLog::whereDate('created_at', $today)->avg('temperature');
        $averageTemp = $averageTemp ? round($averageTemp, 2) : 0;

        // 5. Critical temperature alerts (Logs above 8°C today)
        $criticalAlerts = TemperatureLog::whereDate('created_at', $today)
            ->where('temperature', '>', 8.0)
            ->count();

        // 6. Active refrigerators (Fridges that have at least one log today)
        $activeRefrigerators = Refrigerator::whereHas('temperatureLogs', function ($query) use ($today) {
            $query->whereDate('created_at', $today);
        })->count();

        // 7. Refrigerator health score 
        // (Percentage of refrigerators that are currently 'Safe' or 'Warning', but NOT 'Critical')
        $allFridges = Refrigerator::all();
        $safeCount = 0;
        
        foreach ($allFridges as $fridge) {
            // Re-using the mathematical logic accessor you built in the previous step!
            if ($fridge->daily_risk_metrics['status'] !== 'Critical') {
                $safeCount++;
            }
        }
        $healthScore = $allFridges->count() > 0 
            ? round(($safeCount / $allFridges->count()) * 100, 2) 
            : 0;

        return response()->json([
            'status' => 'success',
            'data' => [
                'inventory' => [
                    'total_bags' => $totalBags,
                    'total_expired' => $totalExpired,
                    'available_by_group' => $stockByGroup
                ],
                'monitoring' => [
                    'active_refrigerators' => $activeRefrigerators,
                    'health_score_percentage' => $healthScore,
                    'average_temperature_today' => $averageTemp,
                    'critical_alerts_today' => $criticalAlerts
                ]
            ]
        ], 200);
    }
}