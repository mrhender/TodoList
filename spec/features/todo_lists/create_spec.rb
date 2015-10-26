require 'spec_helper'

describe "Creating todo lists" do

  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."

    visit "/lists/"
    click_link "New List"
    expect(page).to have_content("New list")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create List"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(List.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(List.count).to eq(0)

    visit "/lists/"
    expect(page).to_not have_content("This is what Im doing today")
  end

  it "displays an error when the todo list has no description" do
    expect(List.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content("error")
    expect(List.count).to eq(0)

    visit "/lists/"
    expect(page).to_not have_content("Grocery list")
  end
end
