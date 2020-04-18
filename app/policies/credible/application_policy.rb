module Credible
  class ApplicationPolicy
    attr_reader :session, :record

    def initialize(session, record)
      @session = session
      @record = record
    end

    def index?
      user
    end

    def show?
      user
    end

    def create?
      user
    end

    def new?
      create?
    end

    def update?
      user
    end

    def edit?
      update?
    end

    def destroy?
      user
    end

    # Helper Methods
    def user
      session.user
    end

    class Scope
      attr_reader :session, :scope

      def initialize(session, scope)
        @session = session
        @scope = scope
      end

      def resolve
        scope.all
      end

      # Helper Methods
      def user
        session.user
      end
    end
  end
end
