import React, { useState } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

function LikeButton(props) {
  const [loading, setLoading] = useState(false)
  const [articleID, setArticleID] = useState(props.article_id)
  const [likeID, setLikeID] = useState(props.like_id)
  const [count, setCount] = useState(props.count)
  const [user, setUser] = useState(props.user)
  
  const alertMessage = () =>{
    alert('ログインが必要です')
  }
  
  const addLike = () =>{
    setLoading(true)
    
    $.ajax({
      type: 'POST',
      url: `/likes`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        liked_article_id: articleID
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setLoading(false)
      setLikeID(response.like.id)
      setCount(response.counts)
    })
  }
  
  const removeLike = () => {
    setLoading(true)
    
    $.ajax({
      type: 'DELETE',
      url: `/likes/${likeID}`,
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setLoading(false)
      setLikeID(null)
      setCount(response.counts)
    })
  }
  
  const liked = likeID !== null
  const notLoggedIn = user == null
  const btnClass = classnames('btn btn-link icon-big',{
                              'liked': liked,
  })
  const spanClass = classnames('like-count')
  
  return (
    <div>
      <button
        className={ btnClass }
        onClick={ notLoggedIn ? () => alertMessage()
                 :      liked ? () =>   removeLike() : () => addLike() }
        disabled={ loading }
      >
        { liked ? <FontAwesomeIcon icon={['fas', 'heart']} />
                : <FontAwesomeIcon icon={['far', 'heart']} /> }
      </button>
      <span className={ spanClass }>{ count }</span>
    </div>
  )
}

export default LikeButton

LikeButton.propTypes = {
  article_id: PropTypes.number.isRequired,
  like_id: PropTypes.number,
  counts: PropTypes.number,
  user: PropTypes.object.isRequired
}