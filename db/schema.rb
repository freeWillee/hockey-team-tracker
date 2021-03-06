# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180927185446) do

  create_table "assist_targets", force: :cascade do |t|
    t.integer "target"
  end

  create_table "goal_targets", force: :cascade do |t|
    t.integer "target"
  end

  create_table "player_teams", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string  "name"
    t.integer "birth_year"
    t.integer "goals"
    t.integer "assists"
    t.integer "GoalTarget_id"
    t.integer "AssistTarget_id"
    t.integer "salary_id"
    t.integer "position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "position"
  end

  create_table "salaries", force: :cascade do |t|
    t.integer "amount"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "email"
    t.string  "password_digest"
    t.integer "super_user"
    t.integer "team_id"
  end

end
