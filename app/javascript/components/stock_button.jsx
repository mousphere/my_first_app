import React, { useState } from "react"
import PropTypes from "prop-types"
import classnames from 'classnames'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

function StockButton(props){
  const [loading, setLoading] = useState(false)
  const [stockID, setStock] = useState(props.stock_id)
  const [articleID, setArticle] = useState(props.article_id)
  const [user, setUser] = useState(props.user)
  
  const alertMessage = () =>{
    alert('記事をストックするにはログインが必要です')
  }
  
  const stockArticle = () =>{
    setLoading(true)
    
    $.ajax({
      type: 'POST',
      url: `/stocks`,
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        stocked_article_id: articleID
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setLoading(false)
      setStock(response.id)
    })
  }

  
  const unstockArticle = () =>{
    setLoading(true)
    
    $.ajax({
      type: 'DELETE',
      url: `/stocks/${stockID}`,
      dataType: 'json',
      contentType: 'application/json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    }).then((response) => {
      setLoading(false)
      setStock(null)
    })
  }

  const isStocking = stockID !== null
  const notLoggedIn = user == null 
  const className = classnames('btn btn-link icon-big',{
    'text-primary': isStocking,
  })
    
  return (
    <div>
      <button
        className={ className }
        onClick={ notLoggedIn ? () => alertMessage()
        　　　　 : isStocking ? () => unstockArticle() : () => stockArticle() }
        disabled={ loading }
      >
        { isStocking ? <FontAwesomeIcon icon={['fas', 'folder-plus']} />
                     : <FontAwesomeIcon icon={['fas', 'folder-open']} /> }
      </button>
    </div>
    )
  }

export default StockButton

StockButton.propTypes = {
  article_id: PropTypes.number.isRequired,
  stock_id: PropTypes.number
}