require 'spec_helper'

describe "posts/edit.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "MyString",
      :content => "MyText",
      :active => false,
      :user_id => 1,
      :competition_id => 1
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_title", :name => "post[title]"
      assert_select "textarea#post_content", :name => "post[content]"
      assert_select "input#post_active", :name => "post[active]"
      assert_select "input#post_user_id", :name => "post[user_id]"
      assert_select "input#post_competition_id", :name => "post[competition_id]"
    end
  end
end
