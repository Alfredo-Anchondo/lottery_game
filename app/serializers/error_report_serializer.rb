class ErrorReportSerializer < ActiveModel::Serializer
  attributes :id, :controller_name, :action_name, :line_number, :referrer_url, :original_path, :enviroment, :description, :backtrace, :error_time
  has_one :user
end
