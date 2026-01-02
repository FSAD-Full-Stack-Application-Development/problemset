class Ps3ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ps3_project, only: %i[ show edit update destroy add_student ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /ps3_projects or /ps3_projects.json
  def index
    @ps3_projects = Ps3Project.all
  end

  # GET /ps3_projects/1 or /ps3_projects/1.json
  def show
  end

  # GET /ps3_projects/new
  def new
    @ps3_project = Ps3Project.new
  end

  # GET /ps3_projects/1/edit
  def edit
  end

  # POST /ps3_projects or /ps3_projects.json
  def create
    @ps3_project = Ps3Project.new(ps3_project_params)

    respond_to do |format|
      if @ps3_project.save
        format.html { redirect_to @ps3_project, notice: "Ps3 project was successfully created." }
        format.json { render :show, status: :created, location: @ps3_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ps3_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ps3_projects/1 or /ps3_projects/1.json
  def update
    respond_to do |format|
      if @ps3_project.update(ps3_project_params)
        format.html { redirect_to @ps3_project, notice: "Ps3 project was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ps3_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ps3_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ps3_projects/1 or /ps3_projects/1.json
  def destroy
    @ps3_project.destroy!

    respond_to do |format|
      format.html { redirect_to ps3_projects_path, notice: "Ps3 project was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # POST /ps3_projects/1/add_student
  def add_student
    student = Ps3Student.find(params[:student_id])
    
    # Check if student is already assigned
    unless @ps3_project.ps3_students.include?(student)
      @ps3_project.ps3_students << student
      redirect_to @ps3_project, notice: "#{student.name} was successfully added to the project."
    else
      redirect_to @ps3_project, alert: "#{student.name} is already on this project."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ps3_project
      @ps3_project = Ps3Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ps3_project_params
      params.require(:ps3_project).permit(:name, :url)
    end
end
