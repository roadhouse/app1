# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_20_005713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "ubs", force: :cascade do |t|
    t.geography "coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer "cod_munic"
    t.integer "cod_cnes"
    t.string "nom_estab"
    t.string "dsc_endereco"
    t.string "dsc_bairro"
    t.string "dsc_cidade"
    t.string "dsc_telefone"
    t.string "dsc_estrut_fisic_ambiencia"
    t.string "dsc_adap_defic_fisic_idosos"
    t.string "dsc_equipamentos"
    t.string "dsc_medicamentos"
  end

end
