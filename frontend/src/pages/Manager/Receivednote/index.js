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

function Receivednote() {
  const [receivednote, setReceivednote] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/receivednote")
      .then((response) => {
        setReceivednote(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);


  return (
    <>
      <h2>Thông Tin Phiếu Nhập Kho</h2>
      {receivednote.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID Nhập Kho</StyledTableCell>
                <StyledTableCell align="left">Tên Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Ngày Nhập Kho</StyledTableCell>
                <StyledTableCell align="left">Tổng Tiền</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {receivednote.map((note, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">
                    {note.ID_NK}
                  </StyledTableCell>
                  <StyledTableCell align="left">{note.TenNV}</StyledTableCell>
                  <StyledTableCell align="left">
                    {new Date(note.NgayNK).toLocaleDateString()}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {note.Tongtien}
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

export default Receivednote;
