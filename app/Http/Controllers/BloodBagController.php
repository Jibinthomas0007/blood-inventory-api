<?php

namespace App\Http\Controllers;

use App\Models\BloodBag;
use Illuminate\Http\Request;

class BloodBagController extends Controller
{
    /**
     * Display a listing of the blood bags (Read All).
     */
    public function index()
    {
        // Eager load the refrigerator to avoid N+1 query problems
        $bloodBags = BloodBag::with('refrigerator.bloodBank')->get();
        
        return response()->json([
            'status' => 'success',
            'data' => $bloodBags
        ], 200);
    }

    /**
     * Store a newly created blood bag (Create).
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'refrigerator_id' => 'required|exists:refrigerators,id',
            'bag_number' => 'required|string|unique:blood_bags,bag_number',
            'blood_group' => 'required|string',
            'donor_name' => 'required|string',
            'collection_date' => 'required|date',
            'expiry_date' => 'required|date|after:collection_date',
            'quantity_ml' => 'required|integer',
            'status' => 'in:Available,Reserved,Dispatched,Expired'
        ]);

        $bloodBag = BloodBag::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Blood bag registered successfully',
            'data' => $bloodBag
        ], 201);
    }

    /**
     * Display the specified blood bag (Read One).
     */
    public function show(string $id)
    {
        $bloodBag = BloodBag::with('refrigerator')->findOrFail($id);

        return response()->json([
            'status' => 'success',
            'data' => $bloodBag
        ], 200);
    }

    /**
     * Update the specified blood bag in storage (Update).
     */
    public function update(Request $request, string $id)
    {
        $bloodBag = BloodBag::findOrFail($id);

        $validated = $request->validate([
            'status' => 'sometimes|in:Available,Reserved,Dispatched,Expired',
            'quantity_ml' => 'sometimes|integer',
            // Add other fields here if you want them to be updatable
        ]);

        $bloodBag->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Blood bag updated successfully',
            'data' => $bloodBag
        ], 200);
    }

    /**
     * Remove the specified blood bag from storage (Delete).
     */
    public function destroy(string $id)
    {
        $bloodBag = BloodBag::findOrFail($id);
        $bloodBag->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Blood bag deleted successfully'
        ], 200);
    }
}