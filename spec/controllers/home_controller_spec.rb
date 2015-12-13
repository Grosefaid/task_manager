require 'spec_helper'

describe HomeController do

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
end