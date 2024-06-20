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

function Voucher() {
  const [voucher, setVoucher] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/voucher")
      .then((response) => {
        setVoucher(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <>
      <h2>Thông Tin Nguyên Liệu Kho</h2>
      {voucher.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>Code Voucher</StyledTableCell>
                <StyledTableCell align="left">Mô tả</StyledTableCell>
                <StyledTableCell align="left">Phần trăm</StyledTableCell>
                <StyledTableCell align="left">Loại</StyledTableCell>
                <StyledTableCell align="left">Số Lượng</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {voucher.map((item, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">{item.Code_Voucher}</StyledTableCell>
                  <StyledTableCell align="left">{item.Mota}</StyledTableCell>
                  <StyledTableCell align="left">{item.Phantram}</StyledTableCell>
                  <StyledTableCell align="left">{item.LoaiMA}</StyledTableCell>
                  <StyledTableCell align="left">{item.SoLuong}</StyledTableCell>
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

export default Voucher;
