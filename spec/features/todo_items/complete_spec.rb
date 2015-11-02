require 'spec_helper'

describe "Completed todo items" do
  let!(:list) { List.create(title: "Grocery list", description: :"Groceries")}
  let!(:item) { list.items.create(content: "Milk")}

  it "is successful when marking a single item complete" do
    expect(item.completed_at).to be_nil
    visit_list(list)
    within dom_id_for(item) do
      click_link "Mark Complete"
    end
    item.reload
    expect(item.completed_at).to_not be_nil
  end

  context "with completed items" do
    let!(:completed_item) {list.items.create(content: "Eggs", completed_at: 5.minutes.ago) }

    it "shows completed items as complete" do
      visit_list(list)
      within dom_id_for(completed_item) do
        expect(page).to have_content(completed_item.completed_at)
      end
    end

    it "does not give option to mark compelte" do
      visit_list(list)
      within dom_id_for(completed_item) do
        expect(page).to_not have_content("Mark Complete")
      end
    end
  end
end
