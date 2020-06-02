import React, {useState, useEffect} from "react"
import classnames from 'classnames'

function ChangingDisplayOrderButton(props){
  const root_url = "/"
  const url = window.location.href
  
  const [option, setOption] = useState(props.option)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  })

  const setInfo = (url, opt) => {
    let type, optionData
    
    if(url === root_url){
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
    return new Promise((resolve, reject) => {
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
        // ページネーションで2ページ目以降を開いている場合は
        // 1ページ目に戻す
        const replaced_url = url.replace(/[\?&]page=[2-9]+/, "")
        window.location.replace(replaced_url)
      })
      resolve()
    })
  }

  const reload = () =>{
    window.location.reload(true)
  }

  const mainFunction = (type, url, opt) =>{
    setOpt(opt)
    .then(setLoadingTrue()
    .then(sendOptionWithAjax(type, url, opt)
    .then(reload())
      )
    )
  }

  const orderByCreatedAtDesk = () =>{
    const [type, opt] = setInfo(url, 0)
    mainFunction(type, url, opt)
  }
  
  const orderByLikesDesk = () =>{
    const [type, opt] = setInfo(url, 1)
    mainFunction(type, url, opt)
  }
  
  const primaryButton = classnames('d-inline-block p-2 mx-2 btn btn-primary')
  const secondaryButton = classnames('d-inline-block p-2 mx-2 btn btn-secondary')
  
  return(
    <div>
      <div className = 'text-center'>
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
            onClick={ () => orderByLikesDesk() }
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