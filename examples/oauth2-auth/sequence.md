# OAuth2 Authorization Code + PKCE Sequence

1. SPA creates `code_verifier` and `code_challenge`.
2. Browser is redirected to `/authorize` with client ID, redirect URI, scope, and challenge.
3. User authenticates and consents.
4. Authorization server redirects to client callback with authorization `code` and `state`.
5. SPA posts `code` + `code_verifier` to `/token` endpoint.
6. Authorization server returns access token (and optional refresh token).
7. SPA calls API with `Authorization: Bearer <access_token>`.
8. Resource server validates token signature, audience, issuer, and expiry.
9. API response returned for valid token; otherwise `401` with remediation hint.
