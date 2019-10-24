import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default class StockButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      loading: false,
      stock: props.stock,
      user: props.user
    }
  }
  
  alertMessage = () =>{
    alert('ログインが必要です')
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
    const notLoggedIn = this.state.user == null
    const className = classnames('btn',{
      'btn-link icon-big text-primary': isStocking,
      'btn-link icon-big': !isStocking
    })
    
    return (
      <button
        className={ className }
        onClick={ notLoggedIn ? this.alertMessage : isStocking ? this.unstock : this.stock }
        disabled={ this.state.loading }
      >
        { isStocking ?
        <FontAwesomeIcon icon={['fas', 'folder-plus']} /> : <FontAwesomeIcon icon={['fas', 'folder-open']} /> }
      </button>
    )
  }
}

StockButton.defaultProps = {
  stock: null
}

StockButton.propTypes = {
  article: PropTypes.object.isRequired,
  stock: PropTypes.object
}