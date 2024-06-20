import { useEffect, useState } from "react";
import axios from "axios";
import styles from "./Receivednote.module.scss";
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
    backgroundColor: "#a6a6a6",
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

function Receivednote() {
  const [id, setID] = useState();
  const [receivednote, setReceivednote] = useState([]);
  const [inforReceivednote, setInforReceivednote] = useState([]);
  const [inforReceivednoteDetail, setInforReceivednoteDetail] = useState([]);
  const [open, setOpen] = useState(false);

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

  useEffect(() => {
    setInforReceivednote(...receivednote.filter((item) => item.ID_NK === id));
    axios
      .get(`http://localhost:500/manager/receivednotedetail/${id}`)
      .then((response) => {
        setInforReceivednoteDetail(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, [id, receivednote]);

  const handleClickOpen = () => {
    setOpen(true);
  };
  const handleClose = () => {
    setOpen(false);
  };
  return (
    <>
      <h2>Thông Tin Phiếu Nhập Kho</h2>
      {receivednote.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID Nhập Kho</StyledTableCell>
                <StyledTableCell>ID Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Tên Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Ngày Nhập Kho</StyledTableCell>
                <StyledTableCell align="left">Tổng Tiền</StyledTableCell>
                <StyledTableCell align="left">Trạng Thái</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {receivednote.map((note) => (
                <StyledTableRow
                  key={note.ID_NK}
                  onClick={() => {
                    setID(note.ID_NK);
                    handleClickOpen();
                  }}
                >
                  <StyledTableCell component="th" scope="row">
                    {note.ID_NK}
                  </StyledTableCell>
                  <StyledTableCell component="th" scope="row">
                    {note.ID_NV}
                  </StyledTableCell>
                  <StyledTableCell align="left">{note.TenNV}</StyledTableCell>
                  <StyledTableCell align="left">
                    {note.NgayNK
                      ? new Date(note.NgayNK).toLocaleDateString()
                      : ""}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {note.TongTien}
                  </StyledTableCell>
                  <StyledTableCell align="left">
                    {note.TrangThai}
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
          PaperProps={{
            style: {
              width: "600px", // Chiều rộng tùy chỉnh
              height: "550px", // Chiều cao tùy chỉnh
            },
          }}
        >
          <DialogTitle sx={{ m: 0, p: 2 }} id="customized-dialog-title">
            <h5>Chi Tiết Phiếu Nhập Kho</h5>
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
              <h5>Thông tin phiếu nhập kho</h5>
              <br />
              {inforReceivednote &&
              Object.keys(inforReceivednote).length > 0 ? (
                <table>
                  <tbody>
                    <tr>
                      <td className={styles.td}>ID Phiếu Nhập Kho</td>
                      <td className={styles.td}>{inforReceivednote.ID_NK}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>ID Nhân Viên</td>
                      <td className={styles.td}>{inforReceivednote.ID_NV}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>Tên Nhân Viên</td>
                      <td className={styles.td}> {inforReceivednote.TenNV}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>Ngày</td>
                      <td className={styles.td}>
                        {inforReceivednote.NgayNK
                          ? new Date(
                              inforReceivednote.NgayNK
                            ).toLocaleDateString("en-US", {
                              year: "numeric",
                              month: "2-digit",
                              day: "2-digit",
                              hour: "2-digit",
                              minute: "2-digit",
                              second: "2-digit",
                            })
                          : ""}
                      </td>
                    </tr>

                    <tr>
                      <td className={styles.td}>Tổng Tiền</td>
                      <td className={styles.td}>
                        {inforReceivednote.TongTien}
                      </td>
                    </tr>
                    <tr>
                      <td className={styles.td}>Trạng Thái</td>
                      <td className={styles.td}>
                        {inforReceivednote.TrangThai}
                      </td>
                    </tr>
                  </tbody>
                </table>
              ) : (
                <p>Chưa có thông tin khách hàng </p>
              )}
            </Typography>
            <Typography gutterBottom>
              <h5>Thông tin các nguyên liệu</h5>
              <br />

              {inforReceivednoteDetail &&
              Object.keys(inforReceivednoteDetail).length > 0 ? (
                <table>
                  <thead>
                    <tr>
                      <td className={styles.td}>ID Nguyên Liệu</td>
                      <td className={styles.td}>Tên Nguyên Liệu</td>
                      <td className={styles.td}>Số Lượng</td>
                      <td className={styles.td}>Đơn Giá</td>
                      <td className={styles.td}>Thành Tiền(VND)</td>
                    </tr>
                  </thead>
                  <tbody>
                    {inforReceivednoteDetail.map((note, index) => (
                      <tr key={index}>
                        <td className={styles.td}>{note.ID_NL}</td>
                        <td className={styles.td}>{note.TenNL}</td>
                        <td className={styles.td}>{note.SoLuong}</td>
                        <td className={styles.td}>{note.DonGia}</td>
                        <td className={styles.td}>{note.ThanhTien}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              ) : (
                <p>Không có món ăn nào</p>
              )}
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

export default Receivednote;
