<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AlertHistory extends Model
{
    protected $fillable = [
        'refrigerator_id', 
        'message', 
        'recorded_temperature'
    ];

    /**
     * Get the refrigerator associated with this alert.
     */
    public function refrigerator(): BelongsTo
    {
        return $this->belongsTo(Refrigerator::class);
    }
}