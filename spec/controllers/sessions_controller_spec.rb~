require 'spec_helper'

describe SessionsController, "Sessions Controller" do
  it "should show login page to user" do
    get :new
    response.should render_template('new')
  end
end


describe SessionsController, "DELETE destroy" do
  it "should set user_id in session to nil and redirect to login page" do
    delete :destroy
    session[:user_id].should be_nil
    response.should redirect_to(login_path)
	end
end
describe SessionsController, "Session Controller" do
  before(:each) do
    @user = mock_model(User)
  end
  
  it "should redirect_to albums_path if valid login" do
		User.should_receive(:find_by_user_name).with("Shubham").and_return(@user)
    @user.should_receive(:authenticate).with("123").and_return(true)
    post :create, :user_name => "Shubham", :password => '123'
    response.should redirect_to(albums_path)
  end
  
  it "should redirect_to login page & display error message if invalid username" do
  	User.should_receive(:find_by_user_name).with("Shubham").and_return(nil)
    post :create, :user_name => "Shubham", :password => '1234'
    response.should render_template 'new'
  end
end

describe SessionsController, "Session Controller" do
  before(:each) do
    @user = mock_model(User)
  end
  
  it "should sets user_id in session to nil and redirect to login page ie; allows user to log-out on clicking logout link" do
    delete :destroy
    session[:user_id].should be_nil
    response.should redirect_to(login_path)
  end
end

describe SessionsController, "Session Controller" do
  before(:each) do
    @user = mock_model(User)
  end
  
  it "should sets user_id in session to nil and redirect to login page ie; allows user to log-out on clicking logout link" do
    delete :destroy
    session[:user_id].should be_nil
    response.should redirect_to(login_path)
  end
end
