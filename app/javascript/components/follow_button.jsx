import React, { useState } from "react"
import classnames from 'classnames'

function FollowButton(props) {
  const [followUserID, setFollowUserID] = useState(props.follow_user.id)
  const [followedUserID, setFollowedUserID] = useState(props.followed_user.id)
  const [relationshipID, setRelationshipID] = useState(props.relationship_id)
  const [followings, setFollowings] = useState(props.followings)
  const [followers, setFollowers] = useState(props.followers)

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
      setFollowers(response.followers)
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
      setFollowers(response.followers)
    })
  }

  const followed = relationshipID !== null
  const notLoggedIn = followUserID == null
  const notFollowed = classnames('btn btn-outline-primary rounded-pill')
  
  return (
    <div>
      { followUserID !== followedUserID &&
        <button
          className={ notFollowed }
          onClick={ notLoggedIn ? () => alertMessage()
                   :   followed ? () => unfollow() : () => follow() }
        >
          { followed ? 'フォロー中' : 'フォローする' }
        </button>
      }
      <span className= "follow-info">
        フォロー {followings}&emsp;フォロワー {followers}
      </span>
    </div>
  )
}

export default FollowButton