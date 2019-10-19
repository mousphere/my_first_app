import React, { Component } from "react"
import PropTypes from "prop-types"

export default class FollowButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      loading: false,
      stock: props.stock
    }
  }
  
  stock = () =>{
    this.setState({
      loading: true
    })
    
    $.ajax({
      type: 'POST',
      url: `/stocks`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        stocked_article_id: this.props.article.id
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      const stock = response
      this.setState({
        loading: false,
        stock
      })
    })
  }
  
  unstock = () => {
    this.setState({
      loading: true
    })
    
    $.ajax({
      type: 'DELETE',
      url: `/stocks/${this.state.stock.id}`,
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      const stock = response
      this.setState({
        loading: false,
        stock: null
      })
    })
  }
  
  render() {
    const isStocking = this.state.stock !== null
    
    return (
      <button onClick={ isStocking ? this.unstock : this.stock } disabled={ this.state.loading }>
        { isStocking ? 'Unstock' : 'Stock' }
      </button>
    )
  }
}

FollowButton.defaultProps = {
  stock: null
}

FollowButton.propTypes = {
  article: PropTypes.object.isRequired,
  stock: PropTypes.object
}