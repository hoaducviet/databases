import React, { useEffect, useState } from "react";
import axios from "axios";

import { styled } from "@mui/material/styles";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell, { tableCellClasses } from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";

const StyledTableCell = styled(TableCell)(({ theme }) => ({
  [`&.${tableCellClasses.head}`]: {
    backgroundColor: theme.palette.common.white,
    color: theme.palette.common.black,
    fontSize: 18,
    fontWeight: "bold",
  },
  [`&.${tableCellClasses.body}`]: {
    fontSize: 16,
  },
}));

const StyledTableRow = styled(TableRow)(({ theme }) => ({
  "&:nth-of-type(odd)": {
    backgroundColor: theme.palette.action.hover,
  },
  // hide last border
  "&:last-child td, &:last-child th": {
    border: 0,
  },
}));

function Dish() {
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
      <h1>Danh sách món ăn</h1>
      {dishes.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>IDn</StyledTableCell>
                <StyledTableCell align="left">Loại</StyledTableCell>
                <StyledTableCell align="left">Tên Món</StyledTableCell>
                <StyledTableCell align="left">Trạng Thái</StyledTableCell>
                <StyledTableCell align="left">Đơn Giá</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {dishes.map((dish, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">
                    {dish.ID_MonAn}
                  </StyledTableCell>
                  <StyledTableCell align="left">{dish.Loai}</StyledTableCell>
                  <StyledTableCell align="left">{dish.TenMon}</StyledTableCell>
                  <StyledTableCell align="left">
                    {dish.TrangThai}
                  </StyledTableCell>
                  <StyledTableCell align="left">{dish.DonGia}</StyledTableCell>
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

export default Dish;
