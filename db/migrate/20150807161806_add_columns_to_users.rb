class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github, :string
    add_column :users, :mobile, :string
    add_column :users, :skype,  :string
    add_column :users, :about,  :text,   default: "Lorem ipsum dolor sit amet, consectetuer " \
      "adipiscing elit, sed diem nonummy nibh euismod tincidunt ut lacreet dolore magna " \
      "aliguam erat volutpat. Ut wisis enim ad minim veniam, quis nostrud exerci tution " \
      "ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis te feugifacilisi. " \
      "Duis autem dolor in hendrerit in vulputate velit esse molestie consequat, vel illum " \
      "dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui " \
      "blandit praesent luptatum zzril delenit au gue duis dolore te feugat nulla facilisi. " \
      "Ut wisi enim ad minim veniam, quis nostrud exerci taion ullamcorper suscipit lobortis " \
      "nisl ut aliquip ex en commodo consequat. Duis te feugifacilisi per suscipit lobortis " \
      "nisl ut aliquip ex en commodo consequat.Lorem ipsum dolor sit amet, consectetuer adipiscing " \
      "elit, sed diem nonummy nibh euismod tincidunt ut lacreet dolore magna aliguam erat volutpat."
    add_column :users, :image_192, :string
  end
end
