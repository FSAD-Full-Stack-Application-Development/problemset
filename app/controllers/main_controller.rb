class MainController < ApplicationController
  def index
    # Main hub: links to your problem sets
    @problems = [
      { id: 1, title: "Problem Set 1: AI News Aggregator", path: ps1_path, description: "Full-stack web application for aggregating and displaying AI-related news" },
      { id: 2, title: "Problem Set 2: Tech Jokes Database", path: ps2_path, description: "SQL-driven web application with CRUD operations" },
      { id: 3, title: "Problem Set 3: Project Tracker", path: ps3_path, description: "User Acceptance Testing with BDD using Cucumber and Devise authentication" },
      { id: 4, title: "Problem Set 4: User Management", path: ps4_path, description: "Requirements specification for class project with user profiles and system design" },
      { id: 5, title: "Problem Set 5: User Evaluation", path: ps5_path, description: "Peer review and user feedback analysis with constructive criticism and action plans" }
    ]
  end
 end