import React, { Component } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

class Popup extends Component {
  render() {
    return (
      <div className='popup'>
        <div className='popup_inner text-center'>
          <b>この記事を削除しますか？</b>
          <p>この操作は取り消せません。このサイト上全てのページで表示されていた記事が削除されます。</p>
          <div className='modal-button'>
            <button className='btn btn-light' onClick={this.props.closePopup}>キャンセル</button>
            <button className='btn btn-danger' onClick={this.props.closePopup}>削除</button>
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
          <Popup closePopup={this.togglePopup.bind(this)} />
          : null
        }
      </div>
    )
  }
}

ArticleDeleteButton.defaultProps = {
}

ArticleDeleteButton.propTypes = {
}