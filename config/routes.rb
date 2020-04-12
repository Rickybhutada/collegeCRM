Rails.application.routes.draw do

  # Admin controller Routes
  resources :admin do
    collection do
      get 'teacher'
      get 'course'
      get 'student'
      get 'new_teacher'
      get 'new_course'
      post 'create_teacher'
      post 'create_course'
      get 'course_by_type', to: :get_course_by_type, as: :get_course_by_type
    end
    member do
      get 'subjects' , to: :course_subjects, as: :subject_course
      get 'new_subject', to: :new_course_subject, as: :new_course_subject
      post 'create_subject', to: :create_course_subject, as: :create_course_subject
    end
  end
  get 'welcome/index', as: :welcome_index

  # Devise user Routes
  devise_for :users,:controllers => {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  devise_scope :user do
    root to: 'users/sessions#new'
  end

  # Teacher controller Routes
  get 'teacher/:id' => 'teachers#dashboard', as: :teacher_dashboard
  get 'teacher/:id/new' => 'teachers#new_class_for_subject', as: :new_class_for_subject
  post 'teacher/:id/create' => 'teachers#create_class_for_subject', as: :create_class_for_subject

  # student controller Routes
  get 'student/attend_class'=>'students#attend_class',as: :attend_class
  get 'student/:id'=>'students#dashboard', as: :student_dashboard

end
