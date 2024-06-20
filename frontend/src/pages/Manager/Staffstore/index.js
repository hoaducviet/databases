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

function Staffstore() {
  const [staffs, setStaffs] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/staffstore")
      .then((response) => {
        setStaffs(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <>
      <h1>Danh Sách Nhân Viên Kho</h1>

      {staffs.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Tên Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Ngày Vào Làm</StyledTableCell>
                <StyledTableCell align="left">SĐT</StyledTableCell>
                <StyledTableCell align="left">Email</StyledTableCell>
                <StyledTableCell align="left">Chức Vụ</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {staffs.map((staff, index) => (
                <StyledTableRow key={index}>
                  <StyledTableCell component="th" scope="row">
                    {staff.ID_NV}
                  </StyledTableCell>
                  <StyledTableCell align="left">{staff.TenNV}</StyledTableCell>
                  <StyledTableCell align="left">
                    {new Date(staff.NgayVL).toLocaleDateString()}
                  </StyledTableCell>
                  <StyledTableCell align="left">{staff.SDT}</StyledTableCell>
                  <StyledTableCell align="left">{staff.Email}</StyledTableCell>
                  <StyledTableCell align="left">{staff.ChucVu}</StyledTableCell>
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

export default Staffstore;
