require 'spec_helper'
describe UsersController, "PUT update" do
	before(:each) do
		@user = mock_model(User)
		controller.should_receive(:login_required).and_return true
		controller.should_receive(:current_user).and_return(@user)
	end
	it "redirect_to users_path if updated" do
		@user.should_receive(:update_attributes).and_return true
		put :update
		response.should redirect_to(albums_path)
	end
	
	it "renders edit if update failed" do
		@user.should_receive(:update_attributes).and_return false
		put :update
		response.should render_template('edit')
	end
end
describe UsersController , "POST create" do
	before (:each) do
		@user = mock_model(User, :id => '1', :save => true)
		@params={"first_name" => 'abc',
			"last_name" => 'def',
			"email_id" => 'abdhj',
			"password" => '1256',
			"user_name" => 'Shubham'
		}
		User.should_receive(:new).with(@params).and_return(@user)
	end
	def do_post
		post :create, :user => @params
	end
	it "calls user model with param values" do
		do_post
	end
	
	it "should redirect_to albums_path" do
		@user.should_receive(:save).and_return true
		do_post
		response.should redirect_to(albums_path)
	end
	
	it "should render new if failed" do
		@user.should_receive(:save).and_return false
		do_post
		response.should render_template('new')
	end

end

describe UsersController , "GET show " do
	before (:each) do
		@user = mock_model(User)
		controller.should_receive(:login_required).and_return true
	end
	it 'redirects to albums_path if user is valid' do
		controller.should_receive(:current_user).and_return(@user)
		get :show
		response.should render_template('show')	
	end

end

describe UsersController , "GET new" do
	before(:each) do
		@user = mock_model(User)
		get :new
	end
	it "creates a new user" do
		@user.should_not be_nil
	end
	it "renders the new user page" do
		response.should render_template("new")
	end
end
describe UsersController, "GET edit" do
	it "renders edit" do
		@user = mock_model(User)
		controller.should_receive(:login_required).and_return true
		controller.should_receive(:current_user).and_return(@user)
		get :edit
		response.should render_template('edit')
	end
end

describe UsersController, "DELETE destroy" do
	it "should delete the user" do
		@user = mock_model(User)
		controller.should_receive(:login_required).and_return true
		controller.should_receive(:current_user).and_return(@user)
		@user.should_receive(:destroy)
		delete :destroy
		response.should redirect_to login_path
	end
	
end
