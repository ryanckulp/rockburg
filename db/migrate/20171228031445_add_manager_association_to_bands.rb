class AddManagerAssociationToBands < ActiveRecord::Migration[5.1]
  def change
    add_reference :bands, :manager, index: true
  end
end
