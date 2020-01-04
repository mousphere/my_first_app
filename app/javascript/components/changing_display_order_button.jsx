import React, {useState} from "react"
import classnames from 'classnames'

function ChangingDisplayOrderButton(props){
  const root_url = "https://b57360db244146fc98d63bdf0ee06acb.vfs.cloud9.us-east-2.amazonaws.com/"
  const url = window.location.href
  
  const [option, setOption] = useState(props.option)
  const [loading, setLoading] = useState(false)
  
  const setInfo = (url, opt) => {
    let type, optionData
    
    if(url == root_url){
      type = 'POST'
      optionData = JSON.stringify({ option: opt })
    }else{
      type = 'GET'
      optionData = { option: opt }
    }
    
    return[type, optionData]
  }
  
  const setLoadingTrue = () =>{
    return new Promise((resolve, reject) => {
      setLoading(true)
      resolve()
    })
  }
  
  const setOpt = (opt) =>{
    return new Promise((resolve, reject) => {
      setOption(opt)
      resolve()
    })
  }
  
  const sendOptionWithAjax = (type, url, option) => {
    $.ajax({
      type: type,
      url: url,
      dataType: 'json',
      contentType: 'application/json',
      data: option,
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      window.location.reload(true)
    })
  }
  
  const orderByCreatedAtDesk = () =>{
    
    const [type, opt] = setInfo(url, 0)
    
    setOpt(opt)
    .then(setLoadingTrue()
    .then(sendOptionWithAjax(type, url, opt)
      )
    )
  }
  
  const orderByCreatedAtAsk = () =>{
    const [type, opt] = setInfo(url, 1)
    
    setOpt(opt)
    .then(setLoadingTrue()
    .then(sendOptionWithAjax(type, url, opt)
      )
    )
  }
  
  const primaryButton = classnames('d-inline-block p-2 mx-2 btn btn-primary')
  const secondaryButton = classnames('d-inline-block p-2 mx-2 btn btn-secondary')
  
  return(
    <div>
      <div className = 'form-group row justify-content-center'>
        <div>
          <button
            className={ option === 0 ? primaryButton : secondaryButton }
            onClick={ () => orderByCreatedAtDesk() }
            disabled={ loading }
          >
            新しい投稿順
          </button>
          <button
            className={ option === 0 ? secondaryButton : primaryButton }
            onClick={ () => orderByCreatedAtAsk() }
            disabled={ loading }
          >
            いいね多い順
          </button>
        </div>
      </div>
    </div>
  )
}

export default ChangingDisplayOrderButton