import * as React from "react";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Typography from "@mui/material/Typography";
import { CardActionArea } from "@mui/material";

import HalfRating from "./Rating";

function CardDish(props) {
  return (
    <div>
    
      <Card sx={{ maxWidth: 320 }}>
        <CardActionArea>
          <CardMedia
            component="img"
            height="280"
            image={props.ImageUrl}
            alt={props.TenMon}
          />
          <CardContent>
            <Typography
              gutterBottom
              variant="body1"
              fontWeight="bold"
              fontSize="29px"
              component="div"
            >
              {props.TenMon}
            </Typography>
            <Typography
              variant="body1"
              fontWeight="bold"
              fontSize="25px"
              color="black"
            >
              <div className="row">
                <div className="col-6">
                  <p>VND {props.DonGia}</p>
                </div>
                <div className="col-6">
                  <HalfRating rating={props.DanhGia} />
                </div>
              </div>
            </Typography>
          </CardContent>
        </CardActionArea>
      </Card>
    </div>
  );
}

export default CardDish;
