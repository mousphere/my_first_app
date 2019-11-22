import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

class Popup extends Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: false,
      delete_article: props.delete_article,
    }
  }
  
  deleteArticle = () => {
    this.setState({
      loading: true
    })

    return new Promise((resolve, reject) => {
      $.ajax({
        type: 'DELETE',
        url: `/articles/${this.state.delete_article.id}`,
        dataType: 'json',
        contentType: 'application/json',
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        }
      })
      resolve()
    })
  }
      
  closePopup = () => {
    return new Promise((resolve, reject) => {
      this.setState({
        loading: true
      })
      this.props.closePopup()
      resolve()
    })
  }
  
  reloadPage = () => {
    return new Promise((resolve, reject) => {
      window.location.reload(true)
      resolve()
    })
  }
  
  render() {
    return (
      <div className='popup'>
        <div className='popup_inner text-center'>
          <b>この記事を削除しますか？</b>
          <p>この操作は取り消せません。このサイト上全てのページで表示されていた記事が削除されます。</p>
          <div className='modal-button'>
            <button className='btn btn-light' onClick={ this.props.closePopup }>キャンセル</button>
            <button className='btn btn-danger' onClick={() =>{ this.deleteArticle()
                                                              .then(this.closePopup)
                                                              .then(this.reloadPage)
                                                              }}>削除</button>
          </div>
        </div>
      </div>
    )
  }
}

export default class ArticleDeleteButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      showPopup: false,
      delete_article: props.delete_article
    }
  }
  
  togglePopup = () =>{
    this.setState({
      showPopup: !this.state.showPopup
    })
  }
  
  render() {
    const className = classnames('btn btn-link icon-big')
    
    return (
      <div>
        <button
          className={ className }
          onClick={this.togglePopup.bind(this)}>
          <FontAwesomeIcon icon={['far', 'trash-alt']} />
        </button>
        {this.state.showPopup ? 
          <Popup delete_article={ this.state.delete_article } closePopup={ this.togglePopup } />
          : null
        }
      </div>
    )
  }
}

ArticleDeleteButton.defaultProps = {
  delete_article: null
}

ArticleDeleteButton.propTypes = {
  delete_article: PropTypes.object.isRequired
}