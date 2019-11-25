import React, { useState, useContext} from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

  const hogeContext = React.createContext([
    { isModalShown: false, deleteArticleID: null }, () => {}
    ])

  function HooksArticleDeleteButton(props){
    const [value, setValue] = useState({ isModalShown: false, deleteArticleID: props.delete_article.id })
    // alert(value.deleteArticleID)
    return(
           <hogeContext.Provider value={[value, setValue]} >
             <ArticleDeleteButton />
           </hogeContext.Provider>
           )
  }
  
  function ArticleDeleteButton(props){
    
    const className = classnames('btn btn-link icon-big')
    const [value, setValue] = useContext(hogeContext)

    return (
      <div>
        <button
        className={ className }
        onClick={() => setValue({ isModalShown: true }) } >
        <FontAwesomeIcon icon={['far', 'trash-alt']} />
        </button>

        {value.isModalShown ? <Modal /> : null }
      </div>
    )
  }

  function Modal(props){
    const [value, setValue] = useContext(hogeContext)
    
    const deleteArticle = () =>{
      // setValue({deleteArticleID: 2 })
      // alert(value.deleteArticleID)
      return new Promise((resolve, reject) => {
        $.ajax({
          type: 'DELETE',
          url: `/articles/${value.deleteArticleID}`,
          dataType: 'json',
          contentType: 'application/json',
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          }
        })
        resolve()
      })
    }
    
    return (
      <div className='popup'>
        <div className='popup_inner text-center'>
          <b>この記事を削除しますか？</b>
          <p>この操作は取り消せません。このサイト上全てのページで表示されていた記事が削除されます。</p>
          <div className='modal-button'>
            <button className='btn btn-light' onClick={() => setValue({ isModalShown: false })}>キャンセル</button>
            <button className='btn btn-danger' onClick={() => deleteArticle().then(setValue({ isModalShown: false })) } >削除</button>
          </div>
        </div>
      </div>
    )
  }
  
export default HooksArticleDeleteButton

HooksArticleDeleteButton.defaultProps = {
  delete_article: null
}

HooksArticleDeleteButton.propTypes = {
  delete_article: PropTypes.object.isRequired
}