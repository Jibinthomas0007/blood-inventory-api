<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TemperatureLog extends Model
{
    protected $fillable = ['refrigerator_id', 'temperature'];

    public function refrigerator(): BelongsTo
    {
        return $this->belongsTo(Refrigerator::class); // [cite: 54, 55]
    }
}
