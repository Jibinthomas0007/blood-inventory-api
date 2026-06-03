<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BloodBagController;


// Public Routes (No token required)
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes (Token required)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    
    // This single line automatically creates the 5 endpoints for GET, POST, PUT, and DELETE
    Route::apiResource('blood-bags', BloodBagController::class);
    
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Analytics & Mathematical Logic Route
    Route::get('/analytics/temperature-risk', [App\Http\Controllers\AnalyticsController::class, 'getTemperatureRiskReport']);

    // Analytics & Mathematical Logic Routes
    Route::get('/analytics/temperature-risk', [App\Http\Controllers\AnalyticsController::class, 'getTemperatureRiskReport']);
    Route::get('/analytics/blood-expiry', [App\Http\Controllers\AnalyticsController::class, 'getBloodExpiryPrediction']);

    // Dashboard Route
    Route::get('/dashboard/overview', [App\Http\Controllers\DashboardController::class, 'getOverview']);
});
