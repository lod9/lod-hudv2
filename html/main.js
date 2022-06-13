window.addEventListener("message", function(event) {
    var vehicle = event.data;
    switch (vehicle.carhud) {
        case 'arabada':
            $('body').css({ 'display': `block` })
                //
            if (vehicle.gear == 0 && vehicle.rpm > 1) {
                $('.gear').text(`R`)
            } else if (vehicle.gear == 0) {
                $('.gear').text(`P`)
            } else if (vehicle.gear > 0) {
                $('.gear').text(vehicle.gear)
            }
            //

            //
            var speedsInt = vehicle.speed.toFixed()
            if (vehicle.speed < 10) {
                $('.speed').text("00" + speedsInt)
            } else if (vehicle.speed < 100) {
                $('.speed').text("0" + speedsInt)
            } else if (vehicle.speed > 100) {
                $('.speed').text(speedsInt)
            }

            //
            $('.fuellevel').text(vehicle.fuel + "%")
            if (vehicle.fuel < 100) {


                $(".fuellevel").text("%" + vehicle.fuel)
                $(document).ready(function() {

                    $('.fuellevel').each(function(f) {

                        var newstr = $(this).text().substring(0, 3);
                        $(this).text(newstr);

                    });

                })
            }
            //

            if (vehicle.far == 0) {
                $('.fa-lightbulb').css({ 'color': `#534F4E` })
            } else if (vehicle.far == 1) {
                $('.fa-lightbulb').css({ 'color': `#AF4949` })
            } else if (vehicle.far == 2) {
                $('.fa-lightbulb').css({ 'color': `#ED3F3F` })
            }
            //
            // 
            if (vehicle.motor > 900.0) {
                $('.fa-triangle-exclamation').css({ 'color': `#00F627` })
            } else if (vehicle.motor > 500.0) {
                $('.fa-triangle-exclamation').css({ 'color': `#F6D300` })
            } else if (vehicle.motor > 100.0) {
                $('.fa-triangle-exclamation').css({ 'color': `#F60000` })
            }
            // data.hunger < 15 && HungerIcon.classList.toggle('flash');
            // data.thirst < 15 && ThirstIcon.classList.toggle('flash');
            // data.stress > 50 && StressIcon.classList.toggle('flash');

            break
        case 'indi':
            $('body').css({ 'display': `none` })
            break
    }



});

// const Health = document.getElementById('.can');
// if (action == 'setHealth') {
//     Health.style.display = 'block';

//     let health = (data.current - 100) / (data.max - 100);
//     health < 0 && (health = 0);

//     if (health) {
//         HealthIcon.classList.remove('fa-skull');
//         HealthIcon.classList.add('fa-heart');
//     } else {
//         HealthIcon.classList.remove('fa-heart');
//         HealthIcon.classList.add('fa-skull');
//     }

//     Circle.HealthIndicator.trail.setAttribute('stroke', health ? 'rgb(35, 35, 35)' : 'rgb(255, 0, 0)');
//     Circle.HealthIndicator.path.setAttribute('stroke', health ? 'rgb(0, 255, 100)' : 'rgb(255, 0, 0)');
//     Circle.HealthIndicator.animate(health);
// }

// $(function() {
//     $(".can").progressbar({
//         value: 37
//     });
// });