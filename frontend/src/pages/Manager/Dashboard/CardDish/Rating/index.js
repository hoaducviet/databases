import * as React from 'react';
import Rating from '@mui/material/Rating';
import Stack from '@mui/material/Stack';

function HalfRating(props){
  return (
    <Stack spacing={1}>
      <Rating name="half-rating-read" defaultValue={props.rating} precision={0.5}  readOnly />
    </Stack>
  );
}

export default HalfRating