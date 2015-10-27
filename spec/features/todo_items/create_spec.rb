require 'spec_helper'

describe "Adding todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}

  def visit_list(list)
    visit "/lists/"
    within "#list_#{list.id}" do
      click_link "List Items"
    end
  end

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
end
