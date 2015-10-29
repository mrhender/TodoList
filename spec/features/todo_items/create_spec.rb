require 'spec_helper'

describe "Adding todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}

## visit_list(list) is included from todo_list_helpers.rb

  it "is successful with valid content" do
    visit_list(list)
    click_link "New Item"
    fill_in "Content", with: "Milk"
    click_button "Save"
    expect(page).to have_content("Added item")
    within("ul.items") do
      expect(page).to have_content("Milk")
    end
  end

  it "displays an error with no content" do
    visit_list(list)
    click_link "New Item"
    fill_in "Content", with: ""
    click_button "Save"
    within("div.flash") do
      expect(page).to have_content("There was a problem adding that item")
    end
    expect(page).to have_content("Content can't be blank")
  end

  it "displays an error with no content less than 2 characters long" do
    visit_list(list)
    click_link "New Item"
    fill_in "Content", with: "1"
    click_button "Save"
    within("div.flash") do
      expect(page).to have_content("There was a problem adding that item")
    end
    expect(page).to have_content("Content is too short")
  end


end
