import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export default class LikeButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      loading: false,
      like: props.like,
      count: props.count,
      user: props.user
    }
  }
  
  alertMessage = () =>{
    alert('ログインが必要です')
  }
  
  addLike = () =>{
    this.setState({
      loading: true
    })
    
    $.ajax({
      type: 'POST',
      url: `/likes`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        liked_article_id: this.props.article.id
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      const like = response.like
      const count = response.count
      this.setState({
        loading: false,
        like,
        count
      })
    })
  }
  
  removeLike = () => {
    this.setState({
      loading: true
    })
    
    $.ajax({
      type: 'DELETE',
      url: `/likes/${this.state.like.id}`,
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      const like = response.like
      const count = response.count
      this.setState({
        loading: false,
        like: null,
        count
      })
    })
  }
  
  render() {
    const contained = this.state.like !== null
    const notLoggedIn = this.state.user == null
    const btnClass = classnames('btn btn-link icon-big',{
      'liked': contained,
    })
    const spanClass = classnames('like-count')
    
    return (
      <div>
        <button
          className={ btnClass }
          onClick={ notLoggedIn ?  this.alertMessage : contained ? this.removeLike : this.addLike }
          disabled={ this.state.loading }
        >
          { contained ? <FontAwesomeIcon icon={['fas', 'heart']} /> : <FontAwesomeIcon icon={['far', 'heart']} /> }
        </button>
        <span className={ spanClass }>{ this.state.count }</span>
      </div>
    )
  }
}

LikeButton.defaultProps = {
  like: null,
  user: null
}

LikeButton.propTypes = {
  article: PropTypes.object.isRequired,
  like: PropTypes.object,
  count: PropTypes.number,
  user: PropTypes.object.isRequired
}