require 'spec_helper'

describe "Viewing todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}
  it "displays no items when a todo list is empty" do
      visit "/lists/"
      within "#list_#{list.id}" do
        click_link "List Items"
      end
      expect(page).to have_content("Items#index")
  end
end
