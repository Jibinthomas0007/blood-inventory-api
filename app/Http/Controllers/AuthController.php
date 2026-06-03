<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{
    /**
     * User Login API
     */
    public function login(Request $request)
    {
        // 1. Validate the incoming request data
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // 2. Attempt to authenticate the user
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid login credentials'
            ], 401);
        }

        // 3. Find the user and generate a Sanctum token
        $user = User::where('email', $request->email)->firstOrFail();
        
        // We attach the user's role to the token abilities (Bonus Feature implemented)
        $token = $user->createToken('auth_token', [$user->role])->plainTextToken;

        return response()->json([
            'status' => 'success',
            'message' => 'User logged in successfully',
            'data' => [
                'user' => $user,
                'access_token' => $token,
                'token_type' => 'Bearer'
            ]
        ], 200);
    }

    /**
     * User Logout API
     */
    public function logout(Request $request)
    {
        // Delete the token that was used to authenticate the current request
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'User logged out successfully'
        ], 200);
    }
}