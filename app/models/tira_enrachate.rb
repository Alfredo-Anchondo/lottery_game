class TiraEnrachate < ActiveRecord::Base
    has_many :relation_enrachate_tiras
    has_many :relation_tira_questions
    has_many :question_enrachates, :through => :relation_tira_questions
    has_many :enrachates, :through => :relation_enrachate_tiras

    after_create :create_relation_enrachate

    def select_display
        return name
    end


    def create_relation_enrachate
        logger.info "entre en el ciclo"
        enracha = Enrachate.where("initial_date < ? and end_date > ? and winner IS NULL",program_date,program_date)

        enracha.each do |game|
          relation = RelationEnrachateTira.new
          relation.enrachate_id = game.id
          relation.tira_enrachate_id = id
            relation.save
        end
    end
end
