import React, { useState } from "react"
import classnames from 'classnames'

function ChangingDisplayOrderButton(){
  const primaryButton = classnames('d-inline-block p-2 mx-2 btn btn-primary')
  const darkButton = classnames('d-inline-block p-2 mx-2 btn btn-secondary')
  
  return(
    <div>
      <div className = 'form-group row justify-content-center'>
        <div>
          <div
            className={ primaryButton }
          >
            新しい投稿順
          </div>
          <div
            className={ darkButton }
          >
            いいね多い順
          </div>
        </div>
      </div>
    </div>
    )
}

export default ChangingDisplayOrderButton