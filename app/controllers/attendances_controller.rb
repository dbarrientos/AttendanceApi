class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :update, :destroy]

  # GET /attendances
  def index
    @attendances = Attendance.all
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
    @attendance.update(attendance_params)
    head :no_content
  end

  # DELETE /attendances/:id
  def destroy
    @attendance.destroy
    head :no_content
  end

  private

  def attendance_params
    # whitelist params
    params.permit(:checkin, :checkout)
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
end
