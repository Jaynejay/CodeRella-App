package com.example.backend.service;

import com.example.backend.dto.LoginRequest;
import com.example.backend.dto.ForgotPasswordRequest;
import com.example.backend.dto.ResetPasswordRequest;
import com.example.backend.model.User;

public interface AuthService {
    User login(LoginRequest loginRequest);
    void forgotPassword(ForgotPasswordRequest request);
    void resetPassword(ResetPasswordRequest request);
} 