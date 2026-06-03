<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class BloodBank extends Model
{
    protected $fillable = ['name', 'location'];

    public function refrigerators(): HasMany
    {
        return $this->hasMany(Refrigerator::class);
    }

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class);
    }
}