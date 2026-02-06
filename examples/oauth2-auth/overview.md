# Scenario Overview

A single-page application authenticates users through an OAuth2 Authorization Server and accesses a protected resource API using short-lived access tokens.

## Goals
- Secure login with PKCE.
- No token storage in localStorage.
- Clear error handling for invalid/expired tokens.
