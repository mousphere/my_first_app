import React, { useState } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

  const HooksArticleDeleteButton = props => {
    return <ArticleDeleteButton />
  }
  
  const ArticleDeleteButton = props => {
    const [showPopup, setShowPopup] = useState(false)
    
    const className = classnames('btn btn-link icon-big')
    return (
      <div>
        <button
        className={ className }
        onClick={() => setShowPopup(true)}>
        <FontAwesomeIcon icon={['far', 'trash-alt']} />
        </button>

        {showPopup ? <Popup /> : null }
      </div>
    )
  }
  
  const Popup = props => {
    return (
      <div className='popup'>
        <div className='popup_inner text-center'>
          <b>この記事を削除しますか？</b>
          <p>この操作は取り消せません。このサイト上全てのページで表示されていた記事が削除されます。</p>
          <div className='modal-button'>
            <button className='btn btn-light'>キャンセル</button>
            <button className='btn btn-danger'>削除</button>
          </div>
        </div>
      </div>
    )
  }

export default HooksArticleDeleteButton
// ArticleDeleteButton.defaultProps = {
//   delete_article: null
// }

// ArticleDeleteButton.propTypes = {
//   delete_article: PropTypes.object.isRequired
// }