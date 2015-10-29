require 'spec_helper'

describe "Editing todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}
  let!(:item) { list.items.create(content: "Milk")}

## visit_list(list) is included from todo_list_helpers.rb

  it "is successful" do
    visit_list(list)
    within "#item_#{item.id}" do
      click_link "Delete"
    end
    expect(page).to have_content("Item was deleted")
    expect(Item.count).to eq(0)
  end
end
