require 'spec_helper'

describe UsersController do

  describe 'GET #dashboard' do

    before { @user = create(:user) }

    context 'renders' do
      it 'renders :dashboard view' do
        get :dashboard, :id => @user
        response.should render_template :dashboard
      end

      it 'renders :application layout' do
        get :dashboard, :id => @user
        response.should render_template :application
      end
    end

    context 'variables' do
      it 'assigns task to @user' do
        get :dashboard, :id => @user
        assigns(:user).should eq(@user)
      end

      it "assigns 10 paginated user's tasks to @tasks" do
        tasks = []
        15.times { tasks << create(:task, :user => @user) }
        5.times { create(:task, :user => nil) }
        10.times { create(:task, :user => @user) }
        get :dashboard, :id => @user, :page => 2
        assigns(:tasks).should eq(tasks[5, 10].reverse)
      end
    end

  end

end