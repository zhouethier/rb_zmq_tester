## Generated from ActionMessage.proto for 
require "beefcake"


class ActionMsg
  include Beefcake::Message

  module ActionType
    START_SCAN = 1
    STATUS_UPDATE = 2
    SCAN_RESULT = 3
  end

  module ConfigFormat
    CSV = 1
    LSE_MAP = 2
  end
end

class ActionMsg
  required :action_type, ActionMsg::ActionType, 1
  optional :configuration_content, :string, 2, :default => "N/A"
  optional :configuration_format, ActionMsg::ConfigFormat, 3, :default => ActionMsg::ConfigFormat::CSV
  optional :diagnostic_data, :string, 4, :default => "N/A"
  optional :scan_status, :string, 5, :default => "N/A"
  optional :upstream_uid, :string, 6, :default => "999999"
end
