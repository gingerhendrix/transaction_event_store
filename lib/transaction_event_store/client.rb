require 'ruby_event_store'

module TransactionEventStore
  class Client < RubyEventStore
    def with_lock(stream, &block)
      repository.with_lock(stream, &block)
    end

    def publish_snapshot(event, stream_name: GLOBAL_STREAM, expected_version: :any)
      validate_expected_version(stream_name, expected_version)
      repository.create_snapshot(event, stream_name)
      :ok
    end

    def notify_subscribers(event)
      event_broker.notify_subscribers(event)
    end

    def last_stream_snapshot(stream_name)
      repository.last_stream_snapshot(stream_name)
    end

    def read_events_forward(stream_name, start: :head, count: page_size)
      raise IncorrectStreamData if stream_name.nil? || stream_name.empty?
      page = Page.new(repository, start, count)
      repository.read_events_forward(stream_name, page.start, page.count)
    end

    def read_events_backward(stream_name, start: :head, count: page_size)
      raise IncorrectStreamData if stream_name.nil? || stream_name.empty?
      page = Page.new(repository, start, count)
      repository.read_events_backward(stream_name, page.start, page.count)
    end

    def read_all_streams_forward(start: :head, count: page_size)
      page = Page.new(repository, start, count)
      repository.read_all_streams_forward(page.start, page.count)
    end

    def read_all_streams_backward(start: :head, count: page_size)
      page = Page.new(repository, start, count)
      repository.read_all_streams_backward(page.start, page.count)
    end

    class Page
      # Allow count to be nil to disable limit
      def initialize(repository, start, count)
        if start.instance_of?(Symbol)
          raise InvalidPageStart unless [:head].include?(start)
        else
          start = start.to_s
          raise InvalidPageStart if start.empty?
          raise EventNotFound unless repository.has_event?(start)
        end
        @start = start
        @count = count
      end
      attr_reader :start, :count
    end
  end
end
