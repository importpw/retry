# retry

Executes the specified command and retries upon failure.

## Example

```bash
#!/usr/bin/env import
import "retry@0.0.2"

retry curl https://flaky-server.com
```
