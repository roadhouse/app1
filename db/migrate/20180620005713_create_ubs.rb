class CreateUbs < ActiveRecord::Migration[5.2]
  def change
    create_table :ubs do |t|
      t.st_point :coordinates, geographic: true
      t.integer :cod_munic, :cod_cnes
      t.string :nom_estab,
               :dsc_endereco,
               :dsc_bairro,
               :dsc_cidade,
               :dsc_telefone,
               :dsc_estrut_fisic_ambiencia,
               :dsc_adap_defic_fisic_idosos,
               :dsc_equipamentos,
               :dsc_medicamentos
    end
  end
end
