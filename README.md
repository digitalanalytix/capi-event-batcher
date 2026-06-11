# CAPI Event Batcher (GTM Server-Side Tag Template)

Batches server-side conversion events and sends them in bulk instead of one HTTP request per event. Cuts outbound request volume on high-traffic server containers.

## Supported Destinations

| Vendor | Endpoint | Batch wrapper | Max batch |
|--------|----------|---------------|-----------|
| OpenAI Conversions API | `bzr.openai.com/v1/events?pid=…` | `{events: […]}` | 1,000 |
| Meta Conversions API | `graph.facebook.com/{ver}/{pixel}/events` | `{data: […]}` | 1,000 |
| TikTok Events API | `business-api.tiktok.com/…/event/track/` | `{event_source, event_source_id, data: […]}` | 1,000 |
| Custom | your HTTPS endpoint | `{events: […]}` | — |

## How It Works

1. Each tag fire **queues one event** (in `templateDataStorage`) and reports success
2. The queue **flushes** — one bulk HTTP request — when either:
   - the queue reaches **Batch Size** (default 20), or
   - the oldest queued event is older than **Max Wait** (default 10 s), checked when the next event arrives

## Event Payload

The batcher does **not** reshape events. Provide a variable returning one event object already shaped for the chosen vendor:

- OpenAI: `{id, type, timestamp_ms, action_source, data: {…}}`
- Meta: `{event_name, event_time, user_data: {…}, custom_data: {…}}`
- TikTok: `{event, event_time, user: {…}, properties: {…}}`

Build it with a custom variable, or transform upstream (e.g., the GA4 Ecommerce Vendor Mapper for the data portion).

## Important Limitations

- **Best-effort delivery.** Queued events live in container memory. If the server instance restarts or scales down before a flush, queued events are lost. Keep Max Wait short on low-traffic containers.
- **Flush requires a next event.** The age check runs when a new event arrives. On very low traffic, an event can wait longer than Max Wait. If you need guaranteed per-event delivery, use the vendor's dedicated tag instead (e.g., OpenAI Conversions API template).
- **All-or-nothing batches (OpenAI).** If one event in an OpenAI batch is invalid, the whole batch is rejected. Validate payloads upstream.
- Tags that queued events report success at queue time; a later flush failure is only visible in container logs.

## Setup

1. Create a tag using the **CAPI Event Batcher** template in your server container
2. Pick the **Vendor** and fill its credentials
3. Point **Event Payload** at your event-object variable
4. Tune **Batch Size** / **Max Wait** for your traffic
5. Trigger on the events you want to forward

## License

Apache 2.0 — see [LICENSE](LICENSE).
