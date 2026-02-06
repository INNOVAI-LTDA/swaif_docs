# Actors and Responsibilities

- **User Agent (Browser)**: Starts login and follows redirects.
- **SPA Client**: Generates PKCE verifier/challenge and exchanges auth code.
- **Authorization Server**: Authenticates user and issues tokens.
- **Resource Server**: Validates bearer tokens and returns protected data.
