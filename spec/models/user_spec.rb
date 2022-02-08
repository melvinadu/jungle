require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should save when email, name, password fields are filled' do

      @user = User.new(
        email: 'a@a.com',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
      )

      @user.save!

      expect(@user.id).to be_present
    end

    it 'should save when email, name, password fields are filled and the passwords should be the same' do

      @user = User.new(
        email: 'aa@a.com',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
      )

      @user.save!

      expect(@user.id).to be_present
      expect(@user.password).to be == (@user.password_confirmation)
    end

    it 'should not save when email, name, password fields are filled and the passwords are not the same' do

      @user = User.new(
        email: 'aa@a.com',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '12345'
      )

      @user.save

      expect(@user.id).not_to be_present
    end

    it 'should not save when email, name, password fields are filled but the email has already been used (not case-sensitive)' do

      @user = User.new(
        email: 'aa@a.com',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
      )

      @user1 = User.new(
        email: 'AA@a.com',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
      )

      @user.save
      @user1.save

      expect(@user.id).to be_present
      expect(@user1.id).not_to be_present
    end

    describe '.authenticate_with_credentials' do
      it 'should authenticate users' do

        @user = User.new(
        email: '123',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
        )

        @user.save

        @user = User.authenticate_with_credentials('123','1234')
  
        expect(@user).to be_present
      end

      it 'should still authenticate when email has extra spaces surrounding it' do

        @user = User.new(
        email: '123',
        name: 'John Smith',
        password: '1234',
        password_confirmation: '1234'
        )

        @user.save

        @user = User.authenticate_with_credentials(' 123 ','1234')
  
        expect(@user).to be_present
      end

      
    end

  end
end
