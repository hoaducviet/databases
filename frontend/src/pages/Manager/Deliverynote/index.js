import React, { useEffect, useState } from "react";
import axios from "axios";

function Deliverynote() {
    const [deliverynote, setDeliverynote] = useState([]);


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
    console.log(deliverynote);
    return (
      <>
        <h1> Deliverynote</h1>
        {deliverynote.length > 0 ? (
                <table className="table">
                <thead>
                    <tr>
                    <th>ID_XK</th>
                    <th>ID_NV</th>
                    <th>Ngày XK</th>
                   
                   
                    </tr>
                </thead>
                <tbody>
                    {deliverynote.map((note,index) => (
                    <tr key={index}>
                        <td>{note.ID_XK}</td>
                        <td>{note.ID_NV}</td>
                        <td>{new Date(note.NgayXK).toLocaleDateString()}</td>
                        
                    </tr>
                    ))}
                </tbody>
                </table>
            ) : (
                <p>Loading...</p>
            )}
      </>
    );
  }
  export default Deliverynote;
  