require 'spec_helper'

describe "Editing todo lists" do
  let!(:list) {
    list = List.create(title: "Groceries", description: "Grocery list")
  }

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."

    list = options[:list]

    visit "/lists/"
    within "#list_#{list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update List"
  end

  it "updates a todo list successfully with correct information" do

    update_todo_list list: list,
    title: "New title",
    description: "New description"

    list.reload

    expect(page).to have_content("List was successfully updated")
    expect(list.title).to eq("New title")
    expect(list.description).to eq("New description")
  end

  it "displays an error with no title" do
    update_todo_list list: list, title:""
    expect(page).to have_content("error")
  end

  it "displays an error with no description" do
    update_todo_list list: list, description: ""
    expect(page).to have_content("error")
  end
end
