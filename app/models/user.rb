class User < ActiveRecord::Base
	 has_attached_file  :image, :styles => {
        :thumb  => "100x100",
        :medium => "200x200",
        :large => "600x400"
        },
     :storage => :s3,
     s3_protocol: "https",
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     # if you're using Rails 3.x, please use #{Rails.root.to_s} instead of #{RAILS_ROOT}
     :path => "/:style/:id/:filename",
     :url  => ":s3_eu_url" # if you're using eu buckets, call it s3_eu_url

     validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Spree::UserReporting
  include Spree::UserApiAuthentication
  has_and_belongs_to_many :spree_roles,
                          :join_table => 'spree_roles_users',
                          :foreign_key => "user_id",
                          :class_name => "Spree::Role"
 
  has_many :spree_orders, :foreign_key => "user_id", :class_name => "Spree::Order"
 
  belongs_to :ship_address, :class_name => 'Spree::Address'
  belongs_to :bill_address, :class_name => 'Spree::Address'
 
  # has_spree_role? simply needs to return true or false whether a user has a role or not.
  def has_spree_role?(role_in_question)
    spree_roles.where(:name => role_in_question.to_s).any?
  end
 
  def last_incomplete_spree_order
    spree_orders.incomplete.where(:created_by_id => self.id).order('created_at DESC').first
  end
 
#user = [find desired user for admin role]
#user.spree_roles << Spree::Role.find_or_create_by(name: "admin")

end
