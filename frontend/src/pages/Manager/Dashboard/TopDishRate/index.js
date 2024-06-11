import React, { useEffect, useState } from "react";
import axios from "axios";
import CardDish from "../CardDish";

function TopDishRate() {
  const [dishesTopRate, setDishesTopRate] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/dish/toprate")
      .then((response) => {
        setDishesTopRate(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <>
      <div className="row">
        <h2>Top món ăn được ưa thích</h2>
        {dishesTopRate.map((dish, index) => (
          <div key={index} className="col-3">
            <CardDish {...dish} />
          </div>
        ))}
      </div>
    </>
  );
}

export default TopDishRate;
