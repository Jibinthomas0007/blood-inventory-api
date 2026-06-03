<?php

namespace App\Http\Controllers;

use App\Models\Refrigerator;
use Illuminate\Http\Request;
use App\Models\BloodBag;
use Carbon\Carbon;

class AnalyticsController extends Controller
{
    /**
     * Get the temperature risk analysis for all refrigerators.
     */
    public function getTemperatureRiskReport()
    {
        $refrigerators = Refrigerator::all();
        
        $report = $refrigerators->map(function ($fridge) {
            return [
                'refrigerator_id' => $fridge->id,
                'identifier' => $fridge->identifier,
                'metrics' => $fridge->daily_risk_metrics // Calls the accessor you just built
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $report
        ], 200);
    }
    
    /**
     * Get the Blood Expiry Prediction Report (Part B)
     */
    public function getBloodExpiryPrediction()
    {
        $today = Carbon::today();
        $tomorrow = Carbon::tomorrow();
        
        // Let's define "near-risk" as anything expiring within the next 7 days
        $nextWeek = Carbon::today()->addDays(7);

        // 1. Identify Already Expired Inventory
        $expiredBags = BloodBag::whereDate('expiry_date', '<', $today)
            ->orWhere('status', 'Expired')
            ->get();

        // 2. Identify Bags Expiring Within 24 Hours (Tomorrow)
        $expiringIn24Hours = BloodBag::whereDate('expiry_date', $tomorrow)->get();

        // 3. Calculate Near-Risk Inventory Percentage
        // First, get all bags that are NOT expired yet
        $totalActiveBags = BloodBag::whereDate('expiry_date', '>=', $today)
            ->where('status', '!=', 'Expired')
            ->count();

        // Next, count how many of those active bags expire in the next 7 days
        $nearRiskCount = BloodBag::whereDate('expiry_date', '>=', $today)
            ->whereDate('expiry_date', '<=', $nextWeek)
            ->where('status', '!=', 'Expired')
            ->count();

        // Calculate the percentage safely
        $nearRiskPercentage = $totalActiveBags > 0 
            ? round(($nearRiskCount / $totalActiveBags) * 100, 2) 
            : 0;

        return response()->json([
            'status' => 'success',
            'data' => [
                'expired_metrics' => [
                    'count' => $expiredBags->count(),
                    'bags' => $expiredBags
                ],
                'expiring_24h_metrics' => [
                    'count' => $expiringIn24Hours->count(),
                    'bags' => $expiringIn24Hours
                ],
                'near_risk_metrics' => [
                    'total_active_bags' => $totalActiveBags,
                    'near_risk_count' => $nearRiskCount,
                    'risk_percentage' => $nearRiskPercentage
                ]
            ]
        ], 200);
    }
}