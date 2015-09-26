describe PostsController do
  let(:admin) { Admin.create!(email: 'foo@ex.com', password: 'barbarbar') }

  describe '#create' do
    let(:subject) { post :create, params }

    context 'logged in as admin' do
      before { sign_in admin }

      context 'with valid params' do
        let(:params) { {  post: { title: 'New post', body: 'stuff' } } }

        it 'redirects to show page' do
          expect(subject).to redirect_to(post_path(Post.first))
        end

        it 'renders a success flash message' do
          post :create, params

          expect(flash[:notice]).to eq('Post saved successfully!')  
        end

        it 'creates a new post record' do
          expect { subject }.to change { Post.count }.by(1) 
        end
      end

      context 'with invalid params' do
        let(:params) { {  post: { title: '', body: 'stuff' } } }

        it 'does not redirect to show page' do
          expect(subject).to render_template('form')
        end

        it 'renders error flash message' do
          post :create, params

          expect(flash[:notice]).to eq("Title can't be blank")
        end
      end 
    end

    context 'not logged in as admin' do
      let(:params) { {  post: { title: 'New post', body: 'stuff' } } }


      it 'redirects to login screen' do
        expect(subject).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe '#update' do
    let!(:post)    { Post.create(title: 'old title', body: 'old body') }
    let(:subject) { put :update, id: post.id, post: params }

    context 'logged in as admin' do
      before { sign_in admin }

      context 'with valid params' do
        let(:params) { { title: 'new title', body: 'new body' } }

        it 'redirects to show page' do
          expect(subject).to redirect_to(post_path(post))
        end

        it 'renders a success flash message' do
          put :update, id: post.id, post: params

          expect(flash[:notice]).to eq('Post saved successfully!')  
        end

        it 'updates the post record' do
          put :update, id: post.id, post: params

          expect(Post.first.title).to eq(params[:title])
        end
      end 

      context 'with invalid params' do
        let(:params) { { title: '', body: 'new body' } }

        it 'does not redirect to show page' do
          expect(subject).to render_template('form')
        end

        it 'renders error flash message' do
          put :update, id: post.id, post: params

          expect(flash[:notice]).to eq("Title can't be blank")
        end
      end
    end

    context 'not logged in as admin' do
      let(:params) { { title: 'New post', body: 'stuff' } }

      it 'redirects to login screen' do
        expect(subject).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe '#destroy' do
    let(:post)       { Post.create(title: 'title', body: 'body') }
    let!(:comment_a) { post.comments.create(name: 'foo a', body: 'bar a') }
    let!(:comment_b) { post.comments.create(name: 'foo b', body: 'bar b') }
    let(:subject)    { delete :destroy, id: post.id }

    context 'logged in as admin' do
      before { sign_in admin }

      it 'redirects to index' do
        expect(subject).to redirect_to(root_path) 
      end

      it 'renders a flash message' do
        delete :destroy, id: post.id

        expect(flash[:notice]).to eq('Post deleted successfully!')
      end

      it 'destroys the post' do
        expect { subject }.to change { Post.count }.by(-1)      
      end

      it 'destroys associated comments' do
        expect { subject }.to change { Comment.count }.by(-2)      
      end
    end

    context 'not logged in as admin' do
      it 'redirects to login screen' do
        expect(subject).to redirect_to(new_admin_session_path) 
      end
    end
  end
end
