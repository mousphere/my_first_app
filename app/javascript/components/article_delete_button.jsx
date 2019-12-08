import React, { useState } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

  function ArticleDeleteButton(props){
    const [isModalShown, setValue] = useState(false)
    const [deleteArticleID, setID] = useState(props.delete_article.id)
    const className = classnames('btn btn-link icon-big')

    return (
      <div>
        <button
          className={ className }
          onClick={() => setValue(true) } >
          <FontAwesomeIcon icon={['far', 'trash-alt']} />
        </button>
        { isModalShown ? <Modal isModalShown = {isModalShown} setValue = {setValue}
                                deleteArticleID = {deleteArticleID} /> : null }
      </div>
    )
  }

  function Modal({ isModalShown, setValue, deleteArticleID }){
    const deleteArticle = () =>{
      return new Promise((resolve, reject) => {
        $.ajax({
          type: 'DELETE',
          url: `/articles/${deleteArticleID}`,
          dataType: 'json',
          contentType: 'application/json',
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          }
        })
        resolve()
      })
    }
    
    const hideModal = () =>{
      return new Promise((resolve, reject) => {
        setValue(false)
        resolve()
      })
    }
    
    const reloadPage = () =>{
      return new Promise((resolve, reject) => {
        window.location.reload(true)
        resolve()
      })
    }
    
    return (
      <div className='popup'>
        <div className='popup_inner text-center'>
          <b>この記事を削除しますか？</b>
          <p>この操作は取り消せません。このサイト上全てのページで表示されていた記事が削除されます。</p>
          <div className='modal-button'>
            <button
              className='btn btn-light'
              onClick={ () => setValue(false) }>
              キャンセル
            </button>
            <button
              className='btn btn-danger' 
              onClick={ () => deleteArticle()
                              .then(hideModal)
                              .then(reloadPage) } >
              削除
            </button>
          </div>
        </div>
      </div>
    )
  }
  
export default ArticleDeleteButton

ArticleDeleteButton.defaultProps = {
  delete_article: null
}

ArticleDeleteButton.propTypes = {
  delete_article: PropTypes.object.isRequired
}