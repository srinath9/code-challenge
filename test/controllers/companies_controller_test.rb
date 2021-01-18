# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class CompaniesControllerTest < ApplicationSystemTestCase
  def setup
    @company = companies(:test_company)
  end

  test 'Index' do
    visit companies_path

    assert_text 'Companies'
    assert_text 'Hometown Painting'
    assert_text 'Wolf Painting'
  end

  test 'Show' do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    city_name =  @company.city.presence || 'Unknown city'
    state_name = @company.state.presence || 'Unknown state'

    assert_text "#{city_name}, #{state_name}"
  end

  test 'Update' do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in('company_name', with: 'Updated Test Company', fill_options: { clear: :backspace })
      fill_in('company_zip_code', with: '93009')
      fill_in('company_color', with: '#ff1230')

      click_button 'Update Company'
    end

    @company.reload

    assert_text "Company #{@company.name} is updated"

    assert_equal 'Updated Test Company', @company.name
    assert_equal '93009', @company.zip_code
    assert_equal 'CA', @company.state
    assert_equal 'Ventura', @company.city
    assert_equal '#ff1230', @company.color
  end

  test 'Create' do
    visit new_company_path

    within('form#new_company') do
      fill_in('company_name', with: 'Test Company')
      fill_in('company_zip_code', with: '28173')
      fill_in('company_phone', with: '5553335555')
      fill_in('company_email', with: 'new_test_company@getmainstreet.com')
      click_button 'Create Company'
    end

    assert_text "Company Test Company is created"

    last_company = Company.last
    puts last_company
    assert_equal 'Test Company', last_company.name
    assert_equal '28173', last_company.zip_code
    assert_equal 'NC', last_company.state
    assert_equal 'Waxhaw', last_company.city

  end

  test 'Destroy' do
    name = @company.name
    visit company_path(@company)
    count = Company.count

    find('#delete_company').click
    page.driver.browser.switch_to.alert.accept

    assert_text "#{name} is deleted successfully"
    assert_equal(Company.count, count - 1)
  end
end
