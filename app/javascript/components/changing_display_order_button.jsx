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

  const setLoadingTrue = (opt) =>{
    return new Promise((resolve, reject) => {
      setLoading(true)
      setOption(opt) // ボタンのカラー変更
      resolve()
    })
  }

  // ajax通信でのリクエストの種類、データ形式を設定する
  const setInfo = (url, opt) => {
    return new Promise((resolve, reject) => {
      let type, optionData
      
      if(url === root_url){
        type = 'POST'
        optionData = JSON.stringify({ option: opt })
      }else{
        type = 'GET'
        optionData = { option: opt }
      }
      resolve([type, optionData])
    })
  }
  
  const sendOptionWithAjax = (url, type, opt) => {
    return new Promise((resolve, reject) => {
      $.ajax({
        type: type,
        url: url,
        dataType: 'json',
        contentType: 'application/json',
        data: opt,
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        }
      }).then((response) => {
        // ページネーションで2ページ目以降を開いている場合は
        // 1ページ目に戻す
        const replaced_url = url.replace(/[\?&]page=[2-9]+/, "")
        window.location.replace(replaced_url)
        resolve()
      })
    })
  }

  const reload = () =>{
    window.location.reload(true)
  }

  const mainFunction = (url, opt) =>{
    setLoadingTrue(opt)
    .then(setInfo(url, opt)
    .then((result) => {
      sendOptionWithAjax(url, result[0], result[1])
    })
    .then(reload())
    )
  }

  const orderByCreatedAtDesk = () =>{
    mainFunction(url, 0)
  }
  
  const orderByLikesDesk = () =>{
    mainFunction(url, 1)
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