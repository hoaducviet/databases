import React, { useEffect, useState } from "react";
import axios from "axios";

function Staffstore (){
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
    console.log(staffs);
    

    return(
        <>
            <h1>Staffstore</h1>
            {staffs.length > 0 ? (
                <table className="table">
                <thead>
                    <tr>
                    <th>ID</th>
                    <th>Tên nhân viên</th>
                    <th>Ngày vào làm</th>
                    <th>Số điện thoại</th>
                    <th>Chức vụ</th>
                    </tr>
                </thead>
                <tbody>
                    {staffs.map((staff) => (
                    <tr key={staff.ID_NV}>
                        <td>{staff.ID_NV}</td>
                        <td>{staff.TenNV}</td>
                        <td>{new Date(staff.NgayVL).toLocaleDateString()}</td>
                        <td>{staff.SDT}</td>
                        <td>{staff.Chucvu}</td>
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

export default Staffstore;