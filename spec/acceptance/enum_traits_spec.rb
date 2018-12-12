describe "enum traits" do
  it "builds traits for each enumerated value" do
    define_model("Task", status: :integer) do
      enum status: { queued: 0, started: 1, finished: 2 }
    end

    FactoryBot.define do
      factory :task do
        traits_for_enum(:status)
      end
    end

    Task.statuses.each do |trait_name, database_value|
      task = FactoryBot.build(:task, trait_name)

      expect(task.send(trait_name)).to eq(database_value)
    end
  end
end
