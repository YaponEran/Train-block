class Rails
  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def start
    puts "Welcome to the Train express app:"

    loop do
      puts "1 - crate Station"
      puts "2 - crate Train"
      puts "3 - create Route"
      puts "4 - add station to the Route"
      puts "5 - delete stattion from the Route"
      puts "6 - assign a route to the train"
      puts "7 - add vagon"
      puts "8 - remove vagon"
      puts "9 - move the train to the route"
      puts "10 - show station list"
      puts "11 - show trains list"
      puts "12 - Exit app!!!"

      choice = gets.chomp.to_i
      
      break if choice == 12

      case choice
        when 1 then create_station
        when 2 then create_train
        when 3 then create_route
        when 4 then add_station_to_route
        when 5 then delete_station_from_route
        when 6 then assign_route_to_train
        when 7 then add_vagon
        when 8 then remove_vagon
        when 9 then move_train_to_route
        when 10 then station_list
        when 11 then train_list
      end
    end
  end

  protected

  def create_station
    puts "Type station name"
    station_name = gets.chomp
    @stations.push(Station.new(station_name))
    puts "Station #{station_name} was created"
  end

  def create_train
    puts "Type type of train: 1 - cargo, 2 - passenger"
    type_of_train = gets.chomp.to_i

    puts "Type train number: "
    number_of_train = gets.chomp.to_i

    case type_of_train
      when 1 then @trains.push(CargoTrain.new(number_of_train))
      when 2 then @trains.push(PassengerTrain.new(number_of_train))
    end
    puts "Train number #{number_of_train} created"
  end

  def create_route
    #station list choose
    puts "Choose start station number: "
    start_index = gets.chomp.to_i
    start_station = @stations[start_index - 1]

    puts "Choose end station number: "
    end_index = gets.chomp.to_i
    end_station = @stations[end_index - 1]

    if start_station && end_station && start_index != end_index
      @routes.push(Route.new(start_station,  end_station))
    end
  end

  def add_station_to_route
    #route list chhose
    puts "Choose route number: "
    route_num = gets.chomp.to_i
    route = @routes[route_num - 1]

    #station list choose
    puts "chosse station number: "
    station_num = gets.chomp.to_i
    insert_station = @stations[station_num - 1]
    
    route.add_station(insert_station)  
    puts "The station added!!!!"
  end

  def delete_station_from_route
    #route list
    puts "Choose route number for remove: "
    route_num = gets.chom.to_i
    route = @routes[route_num - 1]

    #station list
    puts "Choose station number for delete: "
    station_num = gets.chom.to_i
    insert_station = @stations[station_num - 1]

    route.delete_station(insert_station)
    puts "The station was deleted!!!"
  end

  def assign_route_to_train
    #train list
    puts "Choose a train: "
    train_index = gets.chomp.to_i
    train = @trains[train_index - 1]

    #route list
    puts "Choose a route: "
    route_index = gets.chomp.to_i
    route = @routes[route_index - 1]

    train.add_route(route)
    puts "The route choosen"
  end

  def add_vagon
    #train list
    puts "Choose a train"
    train_index = gets.chomp.to_i
    train = @trains[train_index - 1]

    if train.type == :cargo
      num_of_seats = gets.chomp,to_i
      vagon = CargoVagon.new(num_of_seats)
    else
      num_of_volumes = gets.chomp.to_i
      vagon = PassengerVagon.new(num_of_volumes)
    end

    train.add_vagon(train)
    puts "The vagon added!!!"
  end

  def remove_vagon
    puts "Choose a train: "
    train_index = gets.chomp.to_i
    train = @trains[train_index - 1]

    train.remove_vagon(train)
    puts "The vagon removed!!!"
  end

  def move_train_to_route
    #train list
    puts "Choose a train: "
    train_index = gets.chomp.to_i
    train = @trains[train_index - 1]

    direction = gets.chomp.to_i
    case direction
      when 1 then train.move_station
      when 2 then train.comeback_station
    end
  end

  def load_vagon
    puts "Enter vagon number"
    number = gets.choice.to_i
    index = gets.chomp.to_i
    if @trains[index].class.to_s.equal?('PassangerWagon')
      sit_number = gets.chomp.to_i
      @trains[index].take_sit_place(sit_number)
    else
      volume_number = gets.chomp.to_i
      @trains[index].load_volume(volume_number)
  end

  def station_list
    @stations.each {|station, index|
      puts "#{index} : #{station.name}"
    }
  end

  def train_list
    @trains.each {|train, index|
      puts "#{index}: #{train.number} - #{train.type}"
    }
  end

  def route_list
    @routes.each {|route, index| puts "#{index} : #{route}"}
  end 
end
