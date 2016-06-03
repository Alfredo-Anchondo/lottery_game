class ErrorReportsController < ApplicationController
	 load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_error_report, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @error_reports = ErrorReport.all
    respond_with(@error_reports)
  end

  def show
    respond_with(@error_report)
  end

  def new
    @error_report = ErrorReport.new
    respond_with(@error_report)
  end

  def edit
  end

  def create
    @error_report = ErrorReport.new(error_report_params)
    @error_report.save
    respond_with(@error_report)
  end

  def update
    @error_report.update(error_report_params)
    respond_with(@error_report)
  end

  def destroy
    @error_report.destroy
    respond_with(@error_report)
  end

  private
    def set_error_report
      @error_report = ErrorReport.find(params[:id])
    end

    def error_report_params
      params.require(:error_report).permit(:user_id, :controller_name, :action_name, :line_number, :referrer_url, :original_path, :enviroment, :description, :backtrace, :error_time)
    end
end
