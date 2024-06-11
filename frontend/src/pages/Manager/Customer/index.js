import React, { useEffect, useState } from "react";
import axios from "axios";

import { styled } from '@mui/material/styles';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

const StyledTableCell = styled(TableCell)(({ theme }) => ({
  [`&.${tableCellClasses.head}`]: {
    backgroundColor: theme.palette.common.white,
    color: theme.palette.common.black,
    fontSize: 18,
    fontWeight: 'bold',
  },
  [`&.${tableCellClasses.body}`]: {
    fontSize: 16,
  },
}));

const StyledTableRow = styled(TableRow)(({ theme }) => ({
  '&:nth-of-type(odd)': {
    backgroundColor: theme.palette.action.hover,
  },
  // hide last border
  '&:last-child td, &:last-child th': {
    border: 0,
  },
}));

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
      <h2>Danh sách khách hàng</h2>
      {customers.length > 0 ? (
          <TableContainer component={Paper}>
      <Table sx={{ minWidth: 700 }} aria-label="customized table">
        <TableHead>
          <TableRow>
            <StyledTableCell>ID Khách Hàng</StyledTableCell>
            <StyledTableCell align="left">Tên Khách Hàng</StyledTableCell>
            <StyledTableCell align="left">Ngày Tham Gia</StyledTableCell>
            <StyledTableCell align="left">Doanh Số</StyledTableCell>
            <StyledTableCell align="left">Điểm Tích Luỹ</StyledTableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {customers.map((customer) => (
            <StyledTableRow key={customer.ID_KH}>
              <StyledTableCell component="th" scope="row">
                {customer.ID_KH}
              </StyledTableCell>
              <StyledTableCell align="left">{customer.TenKH}</StyledTableCell>
              <StyledTableCell align="left">{new Date(customer.Ngaythamgia).toLocaleDateString()}</StyledTableCell>
              <StyledTableCell align="left">{customer.Doanhso}</StyledTableCell>
              <StyledTableCell align="left">{customer.Diemtichluy}</StyledTableCell>
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
        
      ) : (
        <p>Loading...</p>
      )}
    </>
  );
}

export default Customer;


// {customers.length > 0 ? (
//   <table className="table">
//     <thead>
//       <tr>
//         <th>ID</th>
//         <th>Name</th>
//         <th>Join Date</th>
//         <th>Revenue</th>
//         <th>Accumulated Points</th>
//       </tr>
//     </thead>
//     <tbody>
//       {customers.map((customer) => (
//         <tr key={customer.ID_KH}>
//           <td>{customer.ID_KH}</td>
//           <td>{customer.TenKH}</td>
//           <td>{new Date(customer.Ngayhamgia).toLocaleDateString()}</td>
//           <td>{customer.Doanhso}</td>
//           <td>{customer.Diemtichluy}</td>
//         </tr>
//       ))}
//     </tbody>
//   </table>
// ) : (
//   <p>Loading...</p>
// )}