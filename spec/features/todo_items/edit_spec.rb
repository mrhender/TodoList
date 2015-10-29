require 'spec_helper'

describe "Editing todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}
  let!(:item) { list.items.create(content: "Milk")}

## visit_list(list) is included from todo_list_helpers.rb

  it "is successful with valid content" do
    visit_list(list)
    within("#item_#{item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "Lots of Milk"
    click_button "Save"
    expect(page).to have_content("Saved item")
    item.reload
    expect(item.content).to eq("Lots of Milk")
  end

  it "is unsuccessful with no content" do
    visit_list(list)
    within("#item_#{item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: ""
    click_button "Save"
    expect(page).to_not have_content("Saved item")
    expect(page).to have_content("Content can't be blank")
    item.reload
    expect(item.content).to eq("Milk")
  end

  it "is unsuccessful with not enough content" do
    visit_list(list)
    within("#item_#{item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "1"
    click_button "Save"
    expect(page).to_not have_content("Saved item")
    expect(page).to have_content("Content is too short")
    item.reload
    expect(item.content).to eq("Milk")
  end


end
