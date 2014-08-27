$ ->
    $('#go').click ->
        worker = new Worker('show-order.js')
        worker.addEventListener 'message', (event) ->
            console.log event.data