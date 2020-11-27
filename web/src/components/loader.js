import React from 'react';
import CircularProgress from '@material-ui/core/CircularProgress';

export default function CircularIndeterminate() {
  return (
    <div className={'loaderHar'}>
      <CircularProgress color="secondary" />
    </div>
  );
}
