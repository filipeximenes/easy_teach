FactoryGirl.define do
  factory :index do
    slug "chosen_slug"
  end

  factory :teacher do
    name "Fulaninho"
    last_name "de Tal"
    email "fulaninho@detal.com"
    password "fulano123"
    association :index, factory: :index
  end

  factory :classroom do
    name "Turma 101"
    slug "turma_101"
    association :index, factory: :index
  end
end