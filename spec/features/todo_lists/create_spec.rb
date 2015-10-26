require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit "/lists/"
    click_link "New List"
    expect(page).to have_content("New list")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "This is what Im doing today."
    click_button "Create List"

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(List.count).to eq(0)

    visit "/lists/"
    click_link "New List"
    expect(page).to have_content("New list")

    fill_in "Title", with: ""
    fill_in "Description", with: "This is what Im doing today."
    click_button "Create List"

    expect(page).to have_content("error")
    expect(List.count).to eq(0)

    visit "/lists/"
    expect(page).to_not have_content("This is what Im doing today")
  end

  it "displays an error when the todo list has a description less has no description" do
    expect(List.count).to eq(0)

    visit "/lists/"
    click_link "New List"
    expect(page).to have_content("New list")

    fill_in "Title", with: "Grocery list"
    fill_in "Description", with: ""
    click_button "Create List"

    expect(page).to have_content("error")
    expect(List.count).to eq(0)

    visit "/lists/"
    expect(page).to_not have_content("Grocery list")
  end
end
