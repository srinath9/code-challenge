require 'rails_helper'

RSpec.describe Company, type: :model do
  describe do

    describe "table columns" do
      it { should have_db_column(:name) }
      it { should have_db_column(:zip_code) }
      it { should have_db_column(:phone) }
      it { should have_db_column(:email) }
      it { should have_db_column(:services) }
      it { should have_db_column(:state) }
      it { should have_db_column(:city) }
      it { should have_db_column(:color) }
      it { should have_rich_text(:description) }
    end

    describe "validations" do
      it { should allow_value("", nil).for(:email) }
      it { should validate_length_of(:zip_code).is_equal_to(5) }
      it { should_not allow_value("test@gmail.com").for(:email) }
      it { should_not allow_value("test@getmainstreet.comm").for(:email) }
      it { should allow_value("test@getmainstreet.com").for(:email) }
      it { should allow_value("test@getmainstreet.com").for(:email) }
    end

    describe "callbacks" do
      context "before save" do
        let(:company)  {  FactoryBot.create(:company, zip_code: "93003") }
        context "#update_city_and_state" do 
          it { expect(company.city).to match("Ventura") }
          it { expect(company.state).to match("CA") }
        end
      end
    end

    describe "methods" do 
      context "#display_location" do
        context "when valid code is present" do 
          let(:company)  {  FactoryBot.create(:company, zip_code: "93003") }
          it { expect(company.display_location).to match("Ventura, CA") }
        end

        context "when valid code is not present" do 
          let(:company)  {  FactoryBot.create(:company, zip_code: "99999") }
          it { expect(company.display_location).to match("Unknown city, Unknown state") }
        end
      end

      context "#background_color" do
        context "when color attribute is not present" do 
          let(:company) { FactoryBot.create(:company, color: nil) }
          it { expect(company.background_color).to match(Company::DEFAULT_COLOR) }
        end

        context "when color attribute is present" do 
          let(:company) { FactoryBot.create(:company, color: '#ff0123') }
          it { expect(company.background_color).to match('#ff0123') }
        end
      end

    end

  end
end
