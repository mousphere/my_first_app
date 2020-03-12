import React, { useState } from "react"
// import PropTypes from "prop-types"
import classnames from 'classnames'

function FollowButton(props) {
  const [followUser, setFollowUser] = useState(props.follow_user)
  const [followedUserID, setFollowedUserID] = useState(props.followed_user_id)
  const [relationshipID, setRelationshipID] = useState(props.relationship_id)

  const alertMessage = () =>{
    alert('ログインが必要です')
  }
  
  const follow = () =>{
    $.ajax({
      type: 'POST',
      url: `/relationships`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        followed_user_id: followedUserID
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setRelationshipID(response.relationship.id)
    })
  }
  
  const unfollow = () => {
    $.ajax({
      type: 'DELETE',
      url: `/relationships/${relationshipID}`,
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setRelationshipID(null)
    })
  }

  const followed = relationshipID !== null
  const notLoggedIn = followUser == null
  const notFollowed = classnames('btn btn-outline-primary rounded-pill')
  
  return (
    <div>
      <button
        className={ notFollowed }
        onClick={ notLoggedIn ? () => alertMessage()
                 :   followed ? () => unfollow() : () => follow() }
      >
        { followed? 'フォロー中' : 'フォローする' }
      </button>
    </div>
    )
}

export default FollowButton