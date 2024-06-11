import { useEffect, useState } from "react";
import axios from "axios";
import ModalReceipt from "./ModalReceipt";

import * as React from "react";
import Button from "@mui/material/Button";
import { styled } from "@mui/material/styles";
import Dialog from "@mui/material/Dialog";
import DialogTitle from "@mui/material/DialogTitle";
import DialogContent from "@mui/material/DialogContent";
import DialogActions from "@mui/material/DialogActions";
import IconButton from "@mui/material/IconButton";
import CloseIcon from "@mui/icons-material/Close";
import Typography from "@mui/material/Typography";
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
  "&:hover": {
    backgroundColor: "#a3d4f5",
  },
  // hide last border
  "&:last-child td, &:last-child th": {
    border: 0,
  },
}));

const BootstrapDialog = styled(Dialog)(({ theme }) => ({
  "& .MuiDialogContent-root": {
    padding: theme.spacing(2),
  },
  "& .MuiDialogActions-root": {
    padding: theme.spacing(1),
  },
}));

function Receipt() {
  const [id, setID] = useState();
  const [receipts, setReceipts] = useState([]);
  const [inforReceipt, setInforReceipt] = useState([]);
  const [inforReceiptDetail, setInforReceiptDetail] = useState([]);
  const [open, setOpen] = React.useState(false);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/receipt")
      .then((response) => {
        setReceipts(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      const promise1 = axios.get(`http://localhost:500/manager/receipt/${id}`);
      const promise2 = axios.get(`http://localhost:500/manager/receiptdetail/${id}`);

      return Promise.all([promise1, promise2])
        .then((responses) => {
          const [response1, response2] = responses;
          console.log(response2.data.data);


          setInforReceipt(response1.data);
          // setInforReceiptDetail(response2.data);
        })
        .catch((error) => {
          console.error("There was an error!", error);
        });
    };

    fetchData();
  }, [id]);

  const handleClickOpen = () => {
    setOpen(true);
  };
  const handleClose = () => {
    setOpen(false);
  };

  return (
    <>
      <h1>Danh Sách Hoá Đơn</h1>
      {receipts.length > 0 ? (
        <TableContainer component={Paper}>
          <Table
            sx={{ minWidth: 700 }}
            aria-label="customized table"
            elevation={3}
          >
            <TableHead>
              <TableRow>
                <StyledTableCell>ID</StyledTableCell>
                <StyledTableCell align="left">Tên Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Tên Khách Hàng</StyledTableCell>
                <StyledTableCell align="left">Bàn</StyledTableCell>
                <StyledTableCell align="left">Ngày</StyledTableCell>
                <StyledTableCell align="left">Tổng Tiền</StyledTableCell>
                <StyledTableCell align="left">Trạng Thái</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {receipts.map((receipt) => (
                <StyledTableRow
                  key={receipt.ID_HoaDon}
                  onClick={() => {
                    setID(receipt.ID_HoaDon);
                    handleClickOpen();
                  }}
                >
                  <StyledTableCell component="th" scope="row">
                    {receipt.ID_HoaDon}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {receipt.TenKH}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {receipt.TenNV}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {receipt.TenBan}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {new Date(receipt.NgayHD).toLocaleDateString()}
                  </StyledTableCell>

                  <StyledTableCell align="left">
                    {receipt.Tongtien}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {receipt.Trangthai}
                  </StyledTableCell>
                </StyledTableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      ) : (
        <p>Loading...</p>
      )}
      <React.Fragment>
        <BootstrapDialog
          onClose={handleClose}
          aria-labelledby="customized-dialog-title"
          open={open}
        >
          <DialogTitle sx={{ m: 0, p: 2 }} id="customized-dialog-title">
            <h5>Chi Tiết Hoá Đơn</h5>
          </DialogTitle>
          <IconButton
            aria-label="close"
            onClick={handleClose}
            sx={{
              position: "absolute",
              right: 8,
              top: 8,
              color: (theme) => theme.palette.grey[500],
            }}
          >
            <CloseIcon />
          </IconButton>
          <DialogContent dividers>
            <Typography gutterBottom>
              <h5>Thông tin khách hàng</h5>
              <br />
              <p>Khách hàng: {inforReceipt.TenKH}</p>
              <br />
              <p>Bàn: {inforReceipt.TenBan}</p>
              <br />
              <p>Ngày thanh toán: {inforReceipt.NgayHD}</p>
              <br />
              <p>Nhân viên phục vụ: {inforReceipt.TenNV}</p>
              <br />
              <p>ID hoá đơn: {inforReceipt.ID_HoaDon}</p>
              <br />
              <p>Trạng thái: {inforReceipt.Trangthai}</p>
              <br />
            </Typography>
            <Typography gutterBottom>
              <h5>Thông tin mặt hàng</h5>
              <br />

              {inforReceiptDetail.length > 0 ? (
                <TableContainer component={Paper}>
                  <Table
                    aria-label="customized table"
                  >
                    <TableHead>
                      <TableRow>
                        <StyledTableCell>Tên Món</StyledTableCell>
                        <StyledTableCell align="left">Số Lượng</StyledTableCell>
                        <StyledTableCell align="left">
                          Thành Tiền
                        </StyledTableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {inforReceiptDetail.map((item,index) => (
                        <StyledTableRow key={index}>
                          <StyledTableCell component="th" scope="row">
                            {item.TenMon}
                          </StyledTableCell>
                          <StyledTableCell align="left">
                            {item.SoLuong}
                          </StyledTableCell>
                          <StyledTableCell align="left">
                            {item.ThanhTien}
                          </StyledTableCell>
                        </StyledTableRow>
                      ))}
                    </TableBody>
                  </Table>
                </TableContainer>
              ) : (
                <p>Loading...</p>
              )}

            </Typography>
            <Typography gutterBottom>
              <p>Tiền giảm: {inforReceipt.Tiengiam}</p><br/>
              <p>Tổng Tiền: {inforReceipt.Tongtien}</p><br/>
            </Typography>
          </DialogContent>
          <DialogActions>
            <Button autoFocus onClick={handleClose}>
              Đóng
            </Button>
          </DialogActions>
        </BootstrapDialog>
      </React.Fragment>
    </>
  );
}

export default Receipt;
