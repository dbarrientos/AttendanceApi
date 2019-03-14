class V1::AttendancesController < ApplicationController
  load_and_authorize_resource
  before_action :set_attendance, only: [:show, :update, :destroy]

  # GET /attendances
  def index
    if current_user.admin?
      @attendances = Attendance.all
      @attendances = @attendances.where(user_id: params[:usr].to_i) if params[:usr].present?
      @attendances = @attendances.where(attendance_date: params[:a_date].to_date) if params[:a_date].present?
    else
      @attendances = Attendance.where(user: current_user)
      @attendances = @attendances.where(attendance_date: params[:a_date].to_date) if params[:a_date].present?
    end
    json_response(@attendances)
  end

  # POST /attendances
  def create
    @attendance = Attendance.create!(attendance_params)
    json_response(@attendance, :created)
  end

  # GET /attendances/:id
  def show
    json_response(@attendance)
  end

  # PUT /attendances/:id
  def update
    if @attendance.update(attendance_params)
      head :no_content
    else
      json_response(@attendance.errors, :unprocessable_entity)
    end
  end

  # DELETE /attendances/:id
  def destroy
    @attendance.destroy
    head :no_content
  end

  private

  def attendance_params
    # whitelist params
    params.permit(:checkin, :checkout, :user_id, :attendance_date)
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
end
