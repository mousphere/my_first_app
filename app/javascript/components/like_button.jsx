import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'

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
  
  alert_message = () =>{
    alert('ログインが必要です')
  }
  
  add_like = () =>{
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
  
  remove_like = () => {
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
    // const className = classnames('btn',{
    //   'btn-link text-primary': contained,
    //   'btn-link': !contained
    // })
    
    return (
      <div>
        <button
          // className={ className }
          onClick={ notLoggedIn ?  this.alert_message : contained ? this.remove_like : this.add_like }
          disabled={ this.state.loading }
        >
          { contained ? 'いいね！済み' : 'いいね！' }
        </button>
        <span>{ this.state.count }</span>
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