<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BloodBag extends Model
{
    protected $fillable = [
        'refrigerator_id',
        'bag_number',
        'blood_group',
        'donor_name',
        'collection_date',
        'expiry_date',
        'quantity_ml',
        'status'
    ];

    public function refrigerator(): BelongsTo
    {
        return $this->belongsTo(Refrigerator::class); // [cite: 52, 53]
    }
}