{application,restaurant_online,
    [{
        description,"a online order system for restaurant"
    },{
        id, "restaurant_online"
    },{
        modules, [restaurant_online,super_manager,restaurant_online_app]
    },{
        registered,[restaurant_online,super_manager]
    },{
        mod,{restaurant_online_app,[]}
    }]
}.