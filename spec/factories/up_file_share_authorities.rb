FactoryGirl.define do
  factory :up_file_share_authority do
    up_file nil
    user nil
    can_create false
    can_view false
    can_update false
    can_destroy false
  end
end
