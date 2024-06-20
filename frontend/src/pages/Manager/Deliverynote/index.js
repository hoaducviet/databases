import { useEffect, useState } from "react";
import axios from "axios";
import styles from "./Deliverynote.module.scss";
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

function Deliverynote() {
  const [id, setID] = useState();
  const [deliverynote, setDeliverynote] = useState([]);
  const [inforDeliverynote, setInforDeliverynote] = useState([]);
  const [inforDeliverynoteDetail, setInforDeliverynoteDetail] = useState([]);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/deliverynote")
      .then((response) => {
        setDeliverynote(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  useEffect(() => {
    setInforDeliverynote(...deliverynote.filter((item) => item.ID_XK === id));

    axios
      .get(`http://localhost:500/manager/deliverynotedetail/${id}`)
      .then((response) => {
        setInforDeliverynoteDetail(response.data.data);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, [id, deliverynote]);

  const handleClickOpen = () => {
    setOpen(true);
  };
  const handleClose = () => {
    setOpen(false);
  };

  return (
    <>
      <h2>Thông Tin Phiếu Xuất Kho</h2>
      {deliverynote.length > 0 ? (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>ID Xuất Kho</StyledTableCell>
                <StyledTableCell>ID Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Tên Nhân Viên</StyledTableCell>
                <StyledTableCell align="left">Ngày Xuất Kho</StyledTableCell>
                <StyledTableCell align="left">Trạng Thái</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {deliverynote.map((note) => (
                <StyledTableRow
                  key={note.ID_XK}
                  onClick={() => {
                    setID(note.ID_XK);
                    handleClickOpen();
                  }}
                >
                  <StyledTableCell component="th" scope="row">
                    {note.ID_XK}
                  </StyledTableCell>
                  <StyledTableCell component="th" scope="row">
                    {note.ID_NV}
                  </StyledTableCell>
                  <StyledTableCell align="left">{note.TenNV}</StyledTableCell>
                  <StyledTableCell align="left">
                    {note.NgayXK
                      ? new Date(note.NgayXK).toLocaleDateString()
                      : ""}
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
            <h5>Chi Tiết Phiếu Xuất Kho</h5>
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
              <h5>Thông tin phiếu xuất kho</h5>
              <br />
              {inforDeliverynote &&
              Object.keys(inforDeliverynote).length > 0 ? (
                <table>
                  <tbody>
                    <tr>
                      <td className={styles.td}>ID Phiếu Xuất Kho</td>
                      <td className={styles.td}>{inforDeliverynote.ID_XK}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>ID Nhân Viên</td>
                      <td className={styles.td}>{inforDeliverynote.ID_NV}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>Tên Nhân Viên</td>
                      <td className={styles.td}> {inforDeliverynote.TenNV}</td>
                    </tr>
                    <tr>
                      <td className={styles.td}>Ngày</td>
                      <td className={styles.td}>
                        {inforDeliverynote.NgayXK
                          ? new Date(
                              inforDeliverynote.NgayXK
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
                      <td className={styles.td}>Trạng Thái</td>
                      <td className={styles.td}>
                        {inforDeliverynote.TrangThai}
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

              {inforDeliverynoteDetail &&
              Object.keys(inforDeliverynoteDetail).length > 0 ? (
                <table>
                  <thead>
                    <tr>
                      <td className={styles.td}>ID Nguyên Liệu</td>
                      <td className={styles.td}>Tên Nguyên Liệu</td>
                      <td className={styles.td}>Số Lượng</td>
                      <td className={styles.td}>Đơn Vị Tính</td>
                    </tr>
                  </thead>
                  <tbody>
                    {inforDeliverynoteDetail.map((note, index) => (
                      <tr key={index}>
                        <td className={styles.td}>{note.ID_NL}</td>
                        <td className={styles.td}>{note.TenNL}</td>
                        <td className={styles.td}>{note.SoLuong}</td>
                        <td className={styles.td}>{note.Donvitinh}</td>
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
export default Deliverynote;
