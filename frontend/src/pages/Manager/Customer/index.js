import React, { useEffect, useState } from "react";
import axios from "axios";

function Customer() {
  const [customers, setCustomers] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/customer")
      .then((response) => {
        setCustomers(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <>
      <h1>Customer List</h1>
      {customers.length > 0 ? (
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Join Date</th>
              <th>Revenue</th>
              <th>Accumulated Points</th>
            </tr>
          </thead>
          <tbody>
            {customers.map((customer) => (
              <tr key={customer.ID_KH}>
                <td>{customer.ID_KH}</td>
                <td>{customer.TenKH}</td>
                <td>{new Date(customer.Ngayhamgia).toLocaleDateString()}</td>
                <td>{customer.Doanhso}</td>
                <td>{customer.Diemtichluy}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>Loading...</p>
      )}
    </>
  );
}

export default Customer;
