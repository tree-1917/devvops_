> Graph 


```mermaid
architecture-beta
    group frontend_tier["Frontend Tier"]
        service vote["Vote Service - Flask :8080"]
        service result["Result Service - Node.js :8081"]
    end

    group backend_tier["Backend Tier"]
        service worker["Worker Service - .NET Processor"]
        service redis["Redis Queue"]
        service db["PostgreSQL DB"]
    end

    user user["User"]

    user --> vote
    user --> result

    vote --> redis
    redis --> worker
    worker --> db
    result --> db
```