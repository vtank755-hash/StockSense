<?php
/**
 * StockSense - Authentication Functions
 */

/**
 * Require user to be authenticated; redirect to login if not
 */
function requireAuth() {
    if (!isLoggedIn()) {
        redirect(APP_URL . '/auth/login.php');
    }
}

/**
 * Check if user is logged in
 */
function isLoggedIn(): bool {
    return isset($_SESSION['user_id']) && !empty($_SESSION['user_id']);
}

/**
 * Get current logged-in user data
 */
function getCurrentUser(): ?array {
    if (!isLoggedIn()) return null;
    global $db;
    return $db->fetch("SELECT * FROM users WHERE id = ? AND is_active = 1", [$_SESSION['user_id']]);
}

/**
 * Check if current user has a specific role
 */
function hasRole(string $role): bool {
    if (!isLoggedIn()) return false;
    $user = getCurrentUser();
    return $user && $user['role'] === $role;
}

/**
 * Check if current user has any of the given roles
 */
function hasAnyRole(array $roles): bool {
    if (!isLoggedIn()) return false;
    $user = getCurrentUser();
    return $user && in_array($user['role'], $roles);
}

/**
 * Attempt to log in a user
 */
function attemptLogin(string $email, string $password, bool $remember = false): array {
    global $db;
    
    $user = $db->fetch(
        "SELECT * FROM users WHERE (email = ? OR full_name = ?) AND is_active = 1",
        [$email, $email]
    );
    
    if (!$user) {
        return ['success' => false, 'message' => 'Invalid email or password.'];
    }
    
    if (!password_verify($password, $user['password'])) {
        return ['success' => false, 'message' => 'Invalid email or password.'];
    }
    
    // Set session
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['user_name'] = $user['full_name'];
    $_SESSION['user_email'] = $user['email'];
    $_SESSION['user_role'] = $user['role'];
    
    // Handle remember me
    if ($remember) {
        $token = bin2hex(random_bytes(32));
        $db->update('users', ['remember_token' => $token], 'id = ?', [$user['id']]);
        setcookie('remember_token', $token, time() + (86400 * 30), '/');
        setcookie('remember_user', $user['id'], time() + (86400 * 30), '/');
    }
    
    return ['success' => true, 'message' => 'Login successful!', 'user' => $user];
}

/**
 * Register a new user
 */
function registerUser(array $data): array {
    global $db;
    
    // Check if email exists
    $existing = $db->fetch("SELECT id FROM users WHERE email = ?", [$data['email']]);
    if ($existing) {
        return ['success' => false, 'message' => 'Email already registered.'];
    }
    
    // Validate password
    if (strlen($data['password']) < 6) {
        return ['success' => false, 'message' => 'Password must be at least 6 characters.'];
    }
    
    if ($data['password'] !== $data['confirm_password']) {
        return ['success' => false, 'message' => 'Passwords do not match.'];
    }
    
    $userId = $db->insert('users', [
        'full_name' => sanitize($data['full_name']),
        'email' => sanitize($data['email']),
        'phone' => sanitize($data['phone'] ?? ''),
        'password' => password_hash($data['password'], PASSWORD_DEFAULT),
        'role' => $data['role'] ?? 'warehouse_staff',
        'department' => sanitize($data['department'] ?? ''),
    ]);
    
    return ['success' => true, 'message' => 'Account created successfully!', 'user_id' => $userId];
}

/**
 * Generate OTP for password reset
 */
function generateOTP(string $email): array {
    global $db;
    
    $user = $db->fetch("SELECT id, full_name FROM users WHERE email = ? AND is_active = 1", [$email]);
    if (!$user) {
        return ['success' => false, 'message' => 'No account found with that email.'];
    }
    
    // Invalidate old OTPs
    $db->update('otp_tokens', ['is_used' => 1], 'user_id = ? AND is_used = 0', [$user['id']]);
    
    // Generate 6-digit OTP
    $otp = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    
    $db->insert('otp_tokens', [
        'user_id' => $user['id'],
        'otp_code' => $otp,
        'expires_at' => date('Y-m-d H:i:s', strtotime('+10 minutes')),
    ]);
    
    // Store in session for verification page
    $_SESSION['reset_email'] = $email;
    $_SESSION['reset_user_id'] = $user['id'];
    
    return [
        'success' => true,
        'message' => 'OTP has been generated.',
        'otp' => $otp, // In production, this would be sent via email
        'user_name' => $user['full_name']
    ];
}

/**
 * Verify OTP
 */
function verifyOTP(int $userId, string $otp): array {
    global $db;
    
    $token = $db->fetch(
        "SELECT * FROM otp_tokens WHERE user_id = ? AND otp_code = ? AND is_used = 0 AND expires_at > NOW() ORDER BY id DESC LIMIT 1",
        [$userId, $otp]
    );
    
    if (!$token) {
        return ['success' => false, 'message' => 'Invalid or expired OTP.'];
    }
    
    // Mark as used
    $db->update('otp_tokens', ['is_used' => 1], 'id = ?', [$token['id']]);
    $_SESSION['otp_verified'] = true;
    
    return ['success' => true, 'message' => 'OTP verified successfully!'];
}

/**
 * Reset password
 */
function resetPassword(int $userId, string $newPassword, string $confirmPassword): array {
    global $db;
    
    if (strlen($newPassword) < 6) {
        return ['success' => false, 'message' => 'Password must be at least 6 characters.'];
    }
    
    if ($newPassword !== $confirmPassword) {
        return ['success' => false, 'message' => 'Passwords do not match.'];
    }
    
    $db->update('users', [
        'password' => password_hash($newPassword, PASSWORD_DEFAULT)
    ], 'id = ?', [$userId]);
    
    // Clear session reset data
    unset($_SESSION['reset_email'], $_SESSION['reset_user_id'], $_SESSION['otp_verified']);
    
    return ['success' => true, 'message' => 'Password reset successfully! Please login.'];
}

/**
 * Logout the current user
 */
function logout() {
    $_SESSION = [];
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000,
            $params["path"], $params["domain"],
            $params["secure"], $params["httponly"]
        );
    }
    // Clear remember me cookies
    setcookie('remember_token', '', time() - 3600, '/');
    setcookie('remember_user', '', time() - 3600, '/');
    session_destroy();
}

/**
 * Check remember me cookie and auto-login
 */
function checkRememberMe() {
    if (isLoggedIn()) return;
    
    if (isset($_COOKIE['remember_token']) && isset($_COOKIE['remember_user'])) {
        global $db;
        $user = $db->fetch(
            "SELECT * FROM users WHERE id = ? AND remember_token = ? AND is_active = 1",
            [$_COOKIE['remember_user'], $_COOKIE['remember_token']]
        );
        
        if ($user) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_name'] = $user['full_name'];
            $_SESSION['user_email'] = $user['email'];
            $_SESSION['user_role'] = $user['role'];
        }
    }
}
