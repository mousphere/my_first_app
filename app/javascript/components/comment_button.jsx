import React, { useState } from "react"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

function CommentButton(props) {
  const [user, setUser] = useState(props.user)
  
  const alertMessage = () =>{
    alert('ログインが必要です')
  }
  
  const moveToCommentView = () =>{
    window.location.href = '/comments/new'
  }
  
  const notLoggedIn = user == null
  const btnClass = classnames('btn btn-link icon-big')
  
  return (
    <div>
      <button
        className={ btnClass }
        onClick={ notLoggedIn ? () => alertMessage()
                 :              () => moveToCommentView() }
      >
        <FontAwesomeIcon icon={['far', 'comment']} />
      </button>
    </div>
  )
}

export default CommentButton