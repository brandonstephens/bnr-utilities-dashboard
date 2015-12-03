class MoveUtilityOwnershipToPrivileges < ActiveRecord::Migration
  
  class Utility < ActiveRecord::Base
  end

  class Privilege < ActiveRecord::Base
    enum permissions: [:read, :read_write, :owner]
  end

  def up
    Utility.find_each do |utility|
      Privilege.create!(
        utility_id: utility.id,
        user_id: utility.user_id,
        permission: 'owner'
      )
      utility.update(user_id: nil)
    end
  end

  def down
    Utility.find_each do |utility|
      privilege = Privilege.where(
        utility_id: utility.id,
        permission: Privilege.permissions[:owner]
      ).first
      utility.update!(user_id: privilege.user_id)
      privilege.destroy
    end
  end

end
