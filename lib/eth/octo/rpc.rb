module Eth
  module Octo

    class Rpc
      require 'json'
      require 'net/http'

      JSON_RPC_VERSION = '2.0'.freeze

      DEFAULT_CONNECT_OPTIONS = {
        use_ssl: false,
        open_timeout: 10,
        read_timeout: 70
      }.freeze

      DEFAULT_HOST = 'localhost'.freeze
      DEFAULT_PORT = 8545

      attr_reader :eth, :trace

      def initialize(host: DEFAULT_HOST, port: DEFAULT_PORT, connect_options: DEFAULT_CONNECT_OPTIONS)
        @client_id = Random.rand 10_000_000

        @uri = URI((connect_options[:use_ssl] ? 'https' : 'http') + "://#{host}:#{port}#{connect_options[:rpc_path]}")
        @connect_options = connect_options

        @eth = EthModule.new self
        @trace = TraceModule.new self
      end

      def request(method, params = nil)
        Net::HTTP.start(@uri.host, @uri.port, @connect_options) do |http|
          request = Net::HTTP::Post.new @uri, 'Content-Type' => 'application/json'
          request.body = { jsonrpc: JSON_RPC_VERSION, method: method, params: params, id: @client_id }.compact.to_json
          response = http.request request

          raise "Error code #{response.code} on request #{@uri} #{request.body}" unless response.is_a? Net::HTTPOK

          body = JSON.parse(response.body)

          if body['result']
            body['result']
          elsif body['error']
            raise "Error #{@uri} #{body['error']} on request #{@uri} #{request.body}"
          else
            raise "No response on request #{@uri} #{request.body}"
          end
        end
      end
    end
  end
end

unless Hash.method_defined?(:compact)
  class Hash
    def compact
      reject { |_k, v| v.nil? }
    end
  end
end
