require 'spec_helper'

describe "Viewing todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}

  it "displays the title of the todo list"do
  visit_list(list)
  within("h1") do
    expect(page).to have_content(list.title)
  end
end

it "displays no items when a todo list is empty" do
  visit_list(list)
  expect(page.all("ul.items li").size).to eq(0)
end

it "displays item content when a todo list has items" do
  list.items.create(content: "Milk")
  list.items.create(content: "Eggs")

  visit_list(list)

  expect(page.all("ul.items li").size).to eq(2)

  within "ul.items" do
    expect(page).to have_content("Milk")
    expect(page).to have_content("Eggs")
  end
end
end
