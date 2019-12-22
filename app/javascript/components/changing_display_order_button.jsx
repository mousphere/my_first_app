import React from "react"
import classnames from 'classnames'

function ChangingDisplayOrderButton(){
  const primaryButton = classnames('d-inline-block p-2 mx-2 btn btn-primary')
  const darkButton = classnames('d-inline-block p-2 mx-2 btn btn-secondary')
  const root_url = "https://b57360db244146fc98d63bdf0ee06acb.vfs.cloud9.us-east-2.amazonaws.com/"
  
  const setInfo = (url, opt) => {
    let type, data
    
    if(url == root_url){
      type = 'POST'
      data = JSON.stringify({ option: opt })
    }else{
      type = 'GET'
      data = { option: opt }
    }
    
    return[type, data]
  }
  
  const ajaxProcess = (type, url, data) => {
    $.ajax({
      type: type,
      url: url,
      dataType: 'json',
      contentType: 'application/json',
      data: data,
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      window.location.reload(true)
    })
  }
  
  const orderByCreatedAtDesk = () =>{
    const url = window.location.href
    const [type, data] = setInfo(url, 0)
    
    ajaxProcess(type, url, data)
  }
  
  const orderByCreatedAtAsk = () =>{
    const url = window.location.href
    const [type, data] = setInfo(url, 1)
    
    ajaxProcess(type, url, data)
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