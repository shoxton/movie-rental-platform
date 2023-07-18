class RentingService
    
    def initialize(user)
        @user = user
    end

    def new_rental(movie)
    
        if @user.rented.include?(movie)
            return movie
        end

        if movie.available_copies <= 0
            raise DomainException.new "No copies available for renting"
        end

        movie.available_copies -= 1
    
        if movie.save
            @user.rented << movie
            return movie
        end
    end
end

class DomainException < StandardError; end