require 'spec_helper'

describe Task do

  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'state machine' do
    before :each do
      @task = create(:task)
    end

    describe 'states' do
      it 'should be new initial state' do
        @task.should be_new
      end

      it 'should change from new to started' do
        @task.start!
        @task.should be_started
      end

      it 'should change from started to finished' do
        @task.start!
        @task.finish!
        @task.should be_finished
      end

      it 'should not change from new to finished' do
        lambda {@task.send(finish!)}.should raise_error
      end

      it 'should not change from finished to started' do
        @task.start!
        @task.finish!
        lambda {@task.send(start!)}.should raise_error
      end
    end
  end

end