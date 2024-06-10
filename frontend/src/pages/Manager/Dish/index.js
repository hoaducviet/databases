import React, { useEffect, useState } from "react";
import axios from "axios";

function Dish(){
    const [dishes, setDishes] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/dish")
      .then((response) => {
        setDishes(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

    return (
        <>
            <h1>Dish List</h1>
            {dishes.length > 0 ? (
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Loại</th>
              <th>Tên Món</th>
              <th>Trạng thái</th>
              <th>Đơn giá</th>
            </tr>
          </thead>
          <tbody>
            {dishes.map((dish) => (
              <tr key={dish.ID_MonAn}>
                <td>{dish.ID_MonAn}</td>
                <td>{dish.Loai}</td>
                <td>{dish.TenMon}</td>
                <td>{dish.TrangThai}</td>
                <td>{dish.DonGia}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>Loading...</p>
      )}
        </>
    )
}

export default Dish