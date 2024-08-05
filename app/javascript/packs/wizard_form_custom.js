document.addEventListener("turbolinks:load", () => {


    //FUNCIONALIDAD DE FORMULARIO WIZARD  

    function validateFields(activeTab) {
        var requiredFields = activeTab.querySelectorAll('input[required], textarea[required], select[required]');
        var allValid = true;

        if (requiredFields.length > 0) {
            requiredFields.forEach(function (field) {
                if (!field.checkValidity()) {
                    allValid = false;
                    field.reportValidity();
                }
            });
        }

        return allValid;
    }

    function nextTab(elem) {
        elem.nextElementSibling.querySelector('a[data-toggle="tab"]').click();
    }

    function prevTab(elem) {
        elem.previousElementSibling.querySelector('a[data-toggle="tab"]').click();
    }

    var nextSteps = document.querySelectorAll('.next-step');
    var prevSteps = document.querySelectorAll('.prev-step');
    var navTabs = document.querySelectorAll('.nav-tabs li');

    nextSteps.forEach(function (button) {
        button.addEventListener('click', function (e) {
            var activeTab = document.querySelector('.tab-pane.active');
            var activeNav = document.querySelector('.wizard .nav-tabs li.active');
            if (validateFields(activeTab)) {
                activeNav.nextElementSibling.classList.remove('disabled');
                nextTab(activeNav);
            }
            e.preventDefault(); // Prevenir el comportamiento predeterminado
        });
    });

    prevSteps.forEach(function (button) {
        button.addEventListener('click', function (e) {
            var activeNav = document.querySelector('.wizard .nav-tabs li.active');
            prevTab(activeNav);
            e.preventDefault(); // Prevenir el comportamiento predeterminado
        });
    });

    navTabs.forEach(function (tab) {
        tab.addEventListener('click', function (e) {
            if (this.classList.contains('disabled')) {
                e.stopPropagation();
                return;
            }

            var activeNav = document.querySelector('.nav-tabs li.active');
            activeNav.classList.remove('active');
            this.classList.add('active');
            e.preventDefault(); // Prevenir el comportamiento predeterminado
        });
    });

    // Deshabilita inicialmente todos los botones de navegación superior
    navTabs.forEach(function (tab, i) {
        if (i > 0) { // Si no es el primer botón
            tab.classList.add('disabled');
        }
    });


});