require 'rails_helper'

RSpec.describe StandupsController, type: :controller do
  login_admin

  let(:account) { @admin.account }

  let(:valid_attributes) do
    {
      standup_date: Date.today.iso8601,
      todos_attributes: [
        { title: 'YE Old Thingy', "_destroy": 'false' }
      ]
    }
  end

  let(:invalid_attributes) do
    { standup_date: Date.today.iso8601, todos_attributes: [] }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns a new standup as @standup' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #new' do
    it 'redirects without a date' do
      get :new, params: {}, session: valid_session
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #new' do
    it 'assigns a new standup as @standup' do
      get :new, params: { date: Date.today.iso8601 }, session: valid_session
      expect(assigns(:standup)).to be_a_new(Standup)
    end
  end

  describe 'GET #new redirect to edit on existance' do
    it 'it redirects' do
      standup = FactoryBot.create(:standup, user_id: @admin.id)
      get :new, params: { date: standup.standup_date }, session: valid_session
      expect(response).to redirect_to("/s/edit/#{standup.standup_date}")
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested standup as @standup' do
      standup = FactoryBot.create(:standup, user_id: @admin.id)
      get :edit, params: { date: standup.standup_date }, session: valid_session
      expect(assigns(:standup)).to eq(standup)
    end
  end

  describe 'GET #edit redirect to new on non-existance' do
    it 'it redirects' do
      date = Date.today.iso8601
      get :edit, params: { date: date }, session: valid_session
      expect(response).to redirect_to("/s/new/#{date}")
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Standup' do
        expect do
          post(
            :create,
            params: { standup: valid_attributes },
            session: valid_session
          )
        end.to change(Standup, :count).by(1)
      end

      it 'assigns a newly created standup as @standup' do
        post(
          :create,
          params: { standup: valid_attributes },
          session: valid_session
        )
        expect(assigns(:standup)).to be_a(Standup)
        expect(assigns(:standup)).to be_persisted
      end

      it 'redirects to the created standup' do
        post(
          :create,
          params: { standup: valid_attributes },
          session: valid_session
        )
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved standup as @standup' do
        standup = FactoryBot.create(:standup, user_id: @admin.id)
        post(
          :create,
          params: { standup: { standup_date: standup.standup_date } },
          session: valid_session
        )
        expect(assigns(:standup)).to be_a_new(Standup)
      end

      it "re-renders the 'new' template" do
        standup = FactoryBot.create(:standup, user_id: @admin.id)
        post(
          :create,
          params: { standup: { standup_date: standup.standup_date } },
          session: valid_session
        )
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { standup_date: Date.yesterday.iso8601 }
      end

      it 'updates the requested standup' do
        @standup = FactoryBot.create(:standup, user_id: @admin.id)
        put(
          :update,
          params: { id: @standup.to_param, standup: new_attributes },
          session: valid_session
        )
        @standup.reload
        expect(@standup.updated_at).to be > @standup.created_at
      end

      it 'assigns the requested standup as @standup' do
        standup = FactoryBot.create(:standup, user_id: @admin.id)
        put(
          :update,
          params: { id: standup.to_param, standup: valid_attributes },
          session: valid_session
        )
        expect(assigns(:standup)).to eq(standup)
      end

      it 'redirects to the standup' do
        standup = FactoryBot.create(:standup, user_id: @admin.id)
        put(
          :update,
          params: { id: standup.to_param, standup: valid_attributes },
          session: valid_session
        )
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested standup' do
      standup = FactoryBot.create(:standup, user_id: @admin.id)
      expect do
        delete(
          :destroy,
          params: { id: standup.to_param },
          session: valid_session
        )
      end.to change(Standup, :count).by(-1)
    end

    it 'redirects to the standups list' do
      standup = FactoryBot.create(:standup, user_id: @admin.id)
      delete :destroy, params: { id: standup.to_param }, session: valid_session
      expect(response).to redirect_to(standups_url)
    end
  end
end
