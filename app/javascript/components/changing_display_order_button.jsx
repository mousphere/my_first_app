import React, { useState } from "react"
import classnames from 'classnames'

function ChangingDisplayOrderButton(){
  const primaryButton = classnames('d-inline-block p-2 mx-2 btn btn-primary')
  const darkButton = classnames('d-inline-block p-2 mx-2 btn btn-secondary')
  
  const orderByCreatedAtDesk = () =>{
    $.ajax({
      type: 'POST',
      url: `/`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        option: 0
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      window.location.reload(true)
    })
  }
  
  const orderByCreatedAtAsk = () =>{
    $.ajax({
      type: 'POST',
      url: `/`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        option: 1
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      window.location.reload(true)
    })
  }
  
  return(
    <div>
      <div className = 'form-group row justify-content-center'>
        <div>
          <div
            className={ primaryButton }
            onClick={ () => orderByCreatedAtDesk() }
          >
            新しい投稿順
          </div>
          <div
            className={ darkButton }
            onClick={ () => orderByCreatedAtAsk() }
          >
            いいね多い順
          </div>
        </div>
      </div>
    </div>
    )
}

export default ChangingDisplayOrderButton