FactoryGirl.define do
  factory :folder_share_authority do
    folder nil
    user nil
    can_create false
    can_view false
    can_update false
    can_destroy false
  end
end
