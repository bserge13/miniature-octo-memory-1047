require "rails_helper"

RSpec.describe Contestant, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :hometown}
    it {should validate_presence_of :years_of_experience}
  end

  describe "relationships" do
    it {should have_many :contestant_projects}
    it {should have_many(:projects).through(:contestant_projects)}
  end

  describe "model method" do 
    it "calculates the average years of experience" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

      ContestantProject.create(contestant_id: jay.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

      expect(boardfit.contestants.avg_exp).to eq 12 
    end
  end
end
