import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'

export default class LikeButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      loading: false,
      like: props.like
    }
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
      const like = response
      this.setState({
        loading: false,
        like
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
      const like = response
      this.setState({
        loading: false,
        like: null
      })
    })
  }
  
  render() {
    const contained = this.state.like !== null
    // const className = classnames('btn',{
    //   'btn-link text-primary': contained,
    //   'btn-link': !contained
    // })
    
    return (
      <button
        // className={ className }
        onClick={ contained ? this.remove_like : this.add_like }
        disabled={ this.state.loading }
      >
        { contained ? 'いいね！済み' : 'いいね！' }
      </button>
    )
  }
}

LikeButton.defaultProps = {
  like: null
}

LikeButton.propTypes = {
  article: PropTypes.object.isRequired,
  like: PropTypes.object
}