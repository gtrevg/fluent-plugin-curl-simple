#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

module Fluent
  class CurlSimpleOutput < Output
    Plugin.register_output('curl_simple', self)

    config_param :server, :string, :default => "http://localhost"
    config_param :data_key, :string, :default => "json"
    config_param :ssl_verify_peer, :boolean, :default => true
    config_param :verbose, :boolean, :default => false

    def configure(conf)
      super
    end

    def emit(tag, es, chain)
      es.each {|time,record|
        Curl.post(:server, {:data_key, Yajl.dump(record)}) do |curl|
          curl.follow_location = true
          curl.verbose = :verbose
          curl.ssl_verify_peer = :ssl_verify
          #curl.on_missing
          #curl.on_failure
        end
      }

      chain.next
    end
  end
end
