<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Notification;

class CriticalAlertNotification extends Notification implements ShouldQueue
{
    use Queueable;

    protected $refrigerator;

    /**
     * Create a new notification instance.
     */
    public function __construct($refrigerator)
    {
        $this->refrigerator = $refrigerator;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        // Change this from 'mail' to 'database'
        return ['database']; 
    }

    /**
     * Get the array representation of the notification.
     * This is the data that will be saved in the database's notifications table.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'refrigerator_id' => $this->refrigerator->id,
            'message' => 'CRITICAL: Refrigerator ' . $this->refrigerator->identifier . ' has been above 8°C for 10 minutes!',
        ];
    }
}