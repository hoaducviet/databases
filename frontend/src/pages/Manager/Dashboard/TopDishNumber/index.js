import * as React from "react";
import { useEffect, useState } from "react";
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

  "&:last-child td, &:last-child th": {
    border: 0,
  },
}));

function TopDishNumber() {
  const [dishesTopNumber, setDishesTopNumber] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/dish/topnumber")
      .then((response) => {
        setDishesTopNumber(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <div>
      {dishesTopNumber.length > 0 ? (
        <TableContainer component={Paper}>
          <Table aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID</StyledTableCell>
                <StyledTableCell align="left">Đầu bếp</StyledTableCell>
                <StyledTableCell align="left">Tên món</StyledTableCell>
                <StyledTableCell align="left">Đơn giá</StyledTableCell>
                <StyledTableCell align="left">Số lượng</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {dishesTopNumber.map((dish, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">
                    {dish.ID_MonAn}
                  </StyledTableCell>
                  <StyledTableCell align="left">{dish.DauBep}</StyledTableCell>
                  <StyledTableCell align="left">{dish.TenMon}</StyledTableCell>
                  <StyledTableCell align="left">{dish.DonGia}</StyledTableCell>
                  <StyledTableCell align="left">{dish.SoLuong}</StyledTableCell>
                </StyledTableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      ) : (
        <p>Loading...</p>
      )}
    </div>
  );
}

export default TopDishNumber;
