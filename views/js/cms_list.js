$(document).ready(function () {
    overrideDeleteCmsButtons();
    overrideBulkDeleteCmsButtons();
})

/**
 * Sobreescribe el comportamiento de los botones "eliminar" de los CMS (borrado simple)
 * para que antes de realizar ninguna acción, se compruebe si el CMS está protegido por wimgdpr
 */
function overrideDeleteCmsButtons() {
    $("#table-cms").children("tbody").find(".btn-group-action").find(".delete").each(function () {
        $(this).attr("elonclick", $(this).attr("onclick"));
        $(this).attr("onclick", "preDelete(this);event.stopPropagation(); event.preventDefault();");
    })
}

function preDelete(element) {
    var a = $(element);
    var tr = $(a).parent().parent().parent().parent().parent().parent();
    var id = $(tr).children("td:eq( 1 )").text().trim();

    $.ajax({
        type: 'POST',
        async: false,
        url: '../modules/wim_gdpr/ajax.php',
        data: {
            action: "canDeleteCms",
            cms: id
        },
        dataType: 'json',
        success: function (json) {
            // Obtener el mensaje de confirmación
            var mensaje = a.attr("elonclick");
            var start = mensaje.indexOf("'") + 1;
            mensaje = mensaje.substring(start);
            var finish = mensaje.indexOf("'");
            mensaje = mensaje.substring(0, finish);

            if (confirm(mensaje)) {
                if (json["result"] == "true") {
                    // Se elimina (no está protegido por wimgdpr)
                    window.location.href = a.attr("href");
                } else {
                    // no se pude eliminar, mostrar errror
                    showError("No se puede eliminar el CMS porque stá protegido por WebImpacto GDPR");
                }
            } else {
                event.stopPropagation();
                event.preventDefault();
            }
        },
        error: function () {
            // error en el servidor
            showError("Ha ocurrido un error inesperado en el servidor.");
        }
    });
}

/**
 * Sobreescribe el comportamiento del boton "eliminar seleccion" del listado de CMS (borrado multiple)
 * para que antes de eliminar, se compruebe si algún CMS seleccionado está protegido por wimgdpr
 */
function overrideBulkDeleteCmsButtons() {
    var a = $(".bulk-actions").find(".icon-trash").parent();
    a.attr("elonclick", a.attr("onclick"));
    a.attr("onclick", "preDeleteMultiple()");
}


function preDeleteMultiple() {
    var selectedCms = getSelectedCms();

    $.ajax({
        type: 'POST',
        async: false,
        url: '../modules/wim_gdpr/ajax.php',
        data: {
            action: "canDeleteCms",
            cms: selectedCms
        },
        dataType: 'json',
        success: function (json) {
            // Obtener el mensaje de confirmación
            var a = $(".bulk-actions").find(".icon-trash").parent();
            var mensaje = a.attr("elonclick");
            var start = mensaje.indexOf("'") + 1;
            mensaje = mensaje.substring(start);
            var finish = mensaje.indexOf("'");
            mensaje = mensaje.substring(0, finish);

            if (confirm(mensaje)) {
                if (json["result"] == "true") {
                    // Se elimina (no está protegido por wimgdpr)
                    sendBulkAction(a.closest('form').get(0), 'submitBulkdeletecms');
                } else {
                    // no se pude eliminar, mostrar errror
                    showError("No se puede eliminar el CMS porque stá protegido por WebImpacto GDPR");
                }
            }
        },
        error: function () {
            // error en el servidor
            showError("Ha ocurrido un error inesperado en el servidor.");
        }
    });
}

/**
 * Muestra un mensaje de error en la parte superior de la pantalla
 * @param mensaje
 */
function showError(mensaje) {
    var container = $("<div>").addClass("bootstrap");
    var divMsg = $("<div>").addClass("alert alert-danger").text(mensaje);
    var buttonClose = $("<button>").attr({
        type: "button",
        "data-dismiss": "alert"
    }).addClass("close").text("×")
    divMsg.append(buttonClose);
    container.append(divMsg);

    $(container).insertAfter("#content>.bootstrap:eq(0)")
}

/**
 * Devuelve un array con los CMS seleccionados en el listado
 * @returns {Array}
 */
function getSelectedCms() {
    var selectedCms = [];
    $('[name="cmsBox\[\]"]').each(function () {
        if ($(this).is(':checked')) {
            selectedCms.push($(this).val());
        }
    });
    return selectedCms;
}