# Acceptance Criteria

- [ ] Login request includes PKCE parameters and anti-CSRF `state`.
- [ ] Token exchange fails when code verifier is incorrect.
- [ ] API denies requests with expired or malformed access tokens.
- [ ] Client retries with refresh token only when policy permits.
- [ ] Security notes document safe token handling strategy.
