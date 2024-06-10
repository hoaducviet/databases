import React, { useEffect, useState } from 'react';
import axios from 'axios';

function Receipt (){


    const [receipts, setReceipts] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:500/manager/receipt')
      .then(response => {
        setReceipts(response.data.data);
      })
      .catch(error => {
        console.error('There was an error!', error);
      });
  }, []);

    return(
        <>
            <h1>Receipt</h1>
            {receipts.length > 0 ? (
                <table>
                <thead>
                    <tr>
                        <th>ID Hóa đơn</th>
                        <th>ID Nhân viên</th>
                        <th>ID Khách hàng</th>
                        <th>ID Bàn</th>
                        <th>Ngày hóa đơn</th>
                        <th>Mã voucher</th>
                        <th>Tiền giảm</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    {receipts.map((receipt, index) => (
                        <tr key={index}>
                            <td>{receipt.ID_HoaDon}</td>
                            <td>{receipt.ID_NV}</td>
                            <td>{receipt.ID_KH}</td>
                            <td>{receipt.ID_Ban}</td>
                            <td>{new Date(receipt.ngayHD).toLocaleDateString()}</td>
                            <td>{receipt.Code_Voucher}</td>
                            <td>{receipt.Tiengiam}</td>
                            <td>{receipt.Tongtien}</td>
                            <td>{receipt.Trangthai}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
      ) : (
        <p>Loading...</p>
      )}
        </>
    )
}

export default Receipt;