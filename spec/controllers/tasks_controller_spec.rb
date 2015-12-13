require 'spec_helper'

describe TasksController do

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

end