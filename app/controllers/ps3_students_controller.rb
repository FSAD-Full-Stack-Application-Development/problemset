class Ps3StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ps3_student, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_project, only: [:create], if: -> { params[:ps3_project_id].present? }

  # GET /ps3_students or /ps3_students.json
  def index
    @ps3_students = Ps3Student.all
  end

  # GET /ps3_students/1 or /ps3_students/1.json
  def show
  end

  # GET /ps3_students/new
  def new
    @ps3_student = Ps3Student.new
  end

  # GET /ps3_students/1/edit
  def edit
  end

  # POST /ps3_students or /ps3_students.json
  def create
    respond_to do |format|
      # Check if this is a nested route (from project page) or standalone
      if @project
        # Nested: create student and associate with project
        @ps3_student = @project.ps3_students.build(ps3_student_params)
        if @ps3_student.save
          format.html { redirect_to @project, notice: 'Student was successfully created.' }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new }
          format.json { render json: @ps3_student.errors, status: :unprocessable_entity }
        end
      else
        # Standalone: just create student
        @ps3_student = Ps3Student.new(ps3_student_params)
        if @ps3_student.save
          format.html { redirect_to @ps3_student, notice: 'Student was successfully created.' }
          format.json { render :show, status: :created, location: @ps3_student }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @ps3_student.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /ps3_students/1 or /ps3_students/1.json
  def update
    respond_to do |format|
      if @ps3_student.update(ps3_student_params)
        format.html { redirect_to @ps3_student, notice: "Ps3 student was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ps3_student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ps3_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ps3_students/1 or /ps3_students/1.json
  def destroy
    @ps3_student.destroy!

    respond_to do |format|
      format.html { redirect_to ps3_students_path, notice: "Ps3 student was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ps3_student
      @ps3_student = Ps3Student.find(params[:id])
    end

    def set_project
      @project = Ps3Project.find(params[:ps3_project_id])
    end

    # Only allow a list of trusted parameters through.
    def ps3_student_params
      params.require(:ps3_student).permit(:studentid, :name)
    end
end
