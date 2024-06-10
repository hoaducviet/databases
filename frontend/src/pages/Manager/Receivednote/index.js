import React, { useEffect, useState } from "react";
import axios from "axios";

function Receivednote (){
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
    console.log(receivednote);

    return(
        <>
            <h1>Receivednote</h1>
            {receivednote.length > 0 ? (
                <table className="table">
                <thead>
                    <tr>
                    <th>ID_NK</th>
                    <th>ID_NV</th>
                    <th>Ngày NK</th>
                    <th>Tổng tiền</th>
                   
                    </tr>
                </thead>
                <tbody>
                    {receivednote.map((note,index) => (
                    <tr key={index}>
                        <td>{note.ID_NK}</td>
                        <td>{note.ID_NV}</td>
                        <td>{new Date(note.NgayNK).toLocaleDateString()}</td>
                        
                        <td>{note.Tongtien}</td>
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

export default Receivednote;