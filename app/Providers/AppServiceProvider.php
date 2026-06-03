<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\TemperatureLog;
use App\Observers\TemperatureLogObserver;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        TemperatureLog::observe(TemperatureLogObserver::class);
    }
}
