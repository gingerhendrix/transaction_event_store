# TransactionEventStore

An extension of https://github.com/arkency/ruby_event_store with support for pessimistic locking and snapshots.

### Implementations


* [Mongoid](https://github.com/gingerhendrix/transaction_event_store_mongoid)
* Active Record coming soon

### See Also

[Snapshot Aggregate Root](https://github.com/gingerhendrix/snapshot_aggregate_root) an "Aggregate Root" implementation using this event store.

## API

Same as RubyEventStore::Client except the following additions

### Snapshots

* `publish_snapshot` - delegates to `repository#create_snapshot`
* `last_stream_snapshot` - delegates to `repository#last_stream_snapshot`

### Concurrent writers

* `with_lock` method added, which delegates to `repository#with_lock`
* `notify_susbsribers` method added, which exposes the exising `event_broker#notify_subscribers` function (this is used `with_write_context` to ensure event handlers aren't called until after the events are committed)

### Unlimited queries

* Event store reader methods (`read_events_forward` etc), that accept a `count: ` parameter can be passed `count: nil` to disable limits
