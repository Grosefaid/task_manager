require 'spec_helper'

describe TasksController do

  describe 'GET #index' do

    context 'renders' do
      it 'renders :index view' do
        get :index
        response.should render_template :index
      end

      it 'renders :application layout' do
        get :index
        response.should render_template :application
      end
    end

    context 'variables' do
      it 'assigns 10 paginated tasks to @tasks' do
        tasks = []
        25.times do
          tasks << create(:task)
        end
        get :index, :page => 2
        assigns(:tasks).should eq(tasks[5, 10].reverse)
      end
    end

  end

  describe 'GET #show' do

    before { @task = create(:task) }

    context 'renders' do
      it 'renders :show view' do
        get :show, :id => @task
        response.should render_template :show
      end

      it 'renders :application layout' do
        get :show, :id => @task
        response.should render_template :application
      end
    end

    context 'variables' do
      it 'assigns task to @task' do
        get :show, :id => @task
        assigns(:task).should eq(@task)
      end
    end

  end

  describe 'GET #edit' do
    before do
      sign_in :user, create(:user)
      @task = create(:task)
    end

    context 'renders' do
      it 'renders :edit view' do
        get :edit, :id => @task
        response.should render_template :edit
      end

      it 'renders :application layout' do
        get :edit, :id => @task
        response.should render_template :application
      end
    end

    context 'variables' do
      it 'assigns task to @task' do
        get :edit, :id => @task
        assigns(:task).should eq(@task)
      end
    end
  end

  describe 'GET #new' do

    before { sign_in :user, create(:user) }

    context 'renders' do
      it 'renders :new view' do
        get :new
        response.should render_template :new
      end

      it 'renders :application layout' do
        get :new
        response.should render_template :application
      end
    end

    context 'variables' do
      it 'assigns Task object to @task' do
        get :new
        assigns(:task).should be_an_instance_of Task
      end
    end

  end

  describe 'POST #create' do

    before { sign_in :user, create(:user) }

    context 'with valid attributes' do
      it 'creates a new task' do
        expect { post :create, task: attributes_for(:task) }.to change(Task, :count).by(1)
      end

      it 'redirects to the new task' do
        post :create, task: attributes_for(:task)
        response.should redirect_to Task.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new contact' do
        expect { post :create, task: {:name => nil, :description => nil} }.to_not change(Task, :count)
      end

      it 're-renders the new method' do
        post :create, task: {:name => nil, :description => nil}
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do

    before do
      sign_in :user, create(:user)
      @task = create(:task)
    end

    context 'valid attributes' do
      it 'located the requested @contact' do
        put :update, id: @task, task: attributes_for(:task)
        assigns(:task).should eq(@task)
      end

      it "changes @task's attributes" do
        put :update, id: @task, task: {name: 'new name', description: 'new description'}
        @task.reload
        @task.name.should eq('new name')
        @task.description.should eq('new description')
      end

      it 'redirects to the updated contact' do
        put :update, id: @task, task: attributes_for(:task)
        response.should redirect_to @task
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @task' do
        put :update, id: @task, task: {:name => nil, :description => nil}
        assigns(:task).should eq(@task)
      end

      it "does not change @task's attributes" do
        put :update, id: @task, task: {name: 'new name', description: nil}
        @task.reload
        @task.name.should_not eq('new name')
        @task.description.should eq('task description')
      end

      it 're-renders the edit method' do
        put :update, id: @task, task: {:name => nil, :description => nil}
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in :user, create(:user)
      @task = create(:task)
    end

    it 'deletes the task' do
      expect { delete :destroy, id: @task }.to change(Task, :count).by(-1)
    end

    it 'redirects to tasks#index' do
      delete :destroy, id: @task
      response.should redirect_to tasks_url
    end
  end

  describe 'GET #start' do

    before do
      @user = create(:user)
      sign_in :user, @user
      @task = create(:task, :user => @user)
    end

    it 'locates the requested @task' do
      get :start, id: @task
      assigns(:task).should eq(@task)
    end

    it 'starts @task' do
      get :start, id: @task
      assigns(:task).should be_started
    end

    it 'doesnt stark task if current user is not owner' do
      sign_out :user
      get :start, id: @task
      assigns(:task).should be_new
    end

    it 'redirects to tasks#show' do
      get :start, id: @task
      response.should redirect_to task_path(@task)
    end

  end

  describe 'GET #finish' do

    before do
      @user = create(:user)
      sign_in :user, @user
      @task = create(:task, :user => @user)
      @task.start!
    end

    it 'locates the requested @task' do
      get :finish, id: @task
      assigns(:task).should eq(@task)
    end

    it 'finishes @task' do
      get :finish, id: @task
      assigns(:task).should be_finished
    end

    it 'doesnt finish task if current user is not owner' do
      sign_out :user
      get :finish, id: @task
      assigns(:task).should be_started
    end

    it 'redirects to tasks#show' do
      get :finish, id: @task
      response.should redirect_to task_path(@task)
    end

  end

end