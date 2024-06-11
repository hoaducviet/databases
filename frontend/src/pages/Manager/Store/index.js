

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

function Receiveditem() {
  const [store, setStore] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/store")
      .then((response) => {
        setStore(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);


  return (
    <>
      <h2>Thông Tin Nguyên Liệu Kho</h2>
      {store.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID_NL</StyledTableCell>
                <StyledTableCell align="left">Tên NL</StyledTableCell>
                <StyledTableCell align="left">Đơn Giá</StyledTableCell>
                <StyledTableCell align="left">Đơn Vị Tính</StyledTableCell>
                <StyledTableCell align="left">SL Tồn</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {store.map((item, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">
                    {item.ID_NL}
                  </StyledTableCell>
                  <StyledTableCell align="left">{item.TenNL}</StyledTableCell>
                  <StyledTableCell align="left">
                    {item.DonGia}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {item.DonViTinh}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {item.SLTon}
                  </StyledTableCell>
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

export default Receiveditem;
