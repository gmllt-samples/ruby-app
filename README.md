# Ruby JSON Test Server

This is a simple JSON HTTP test server written in Ruby using Sinatra.
It supports dynamic delays, HTTP status codes, and response sizes to help test clients, proxies, or load balancers.

---

## Quick Start

### Requirements

- Ruby 3.1+ (Recommended: use rbenv)
- `make` (optional)

---

## Run the server

```bash
PORT=8080 make run
```

Or manually:

```bash
PORT=8080 ruby app.rb
```

Visit:

```
http://localhost:8080
```

---

## Parameters

You can pass query parameters to control the response:

| Parameter       | Description                        | Examples                           |
|-----------------|------------------------------------|------------------------------------|
| `wait`          | Delay before response (in seconds) | `0.5`, `1-2`, `0.1,0.5,1`          |
| `status`        | HTTP status code                   | `200`, `404`, `200-299`, `200,404` |
| `response_size` | Response body size in bytes/K/M/G  | `100`, `2K`, `1K-2K`, `500,1K,2K`  |

All support:

- **single values**
- **range** (e.g. `1-5`)
- **comma-separated lists** (e.g. `200,404`)

---

## Example `curl` requests

Basic 200 OK response:

```bash
curl "http://localhost:8080"
```

Add delay and custom size:

```bash
curl "http://localhost:8080?wait=1&response_size=5K"
```

Random HTTP status:

```bash
curl "http://localhost:8080?status=200-204"
```

Everything at once:

```bash
curl "http://localhost:8080?wait=0.5&status=500,503&response_size=1K-2K"
```

---

## Makefile commands

```bash
make run     # Start the server
make lint    # Run ruby-lint
```

---

## Project Structure

```
ruby-app/
├── app.rb              # Main app entry
├── routes.rb           # Routes definition
|── server.rb           # Server setup
├── lib/                # Core app logic
│   ├── param_parser.rb # Query parameters parser
│   └── logger.rb       # Request logger
├── handlers/           # Request handlers
│   └── root.rb         # Root handler
├── Makefile
└── README.md
```
