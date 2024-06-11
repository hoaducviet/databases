import * as React from "react";
import { useEffect, useState } from "react";
import axios from "axios";
import { BarChart } from "@mui/x-charts/BarChart";

function OverView() {
  const [xAxisData, setXAxisData] = useState([]);
  const [seriesData, setSeriesData] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost:500/manager/chart/week") // Đảm bảo URL đúng
      .then((response) => {
        const data = response.data.data;
        data.reverse();

        // Chuẩn bị dữ liệu cho xAxis và series
        const xData = [];
        const sData = [];

        data.forEach((item) => {
          const day = new Date(item.NgayHD);
          xData.push(`${day.getDate()}/${day.getMonth() + 1}`);
          sData.push(item.TongTien);
        });

        setXAxisData(xData);
        setSeriesData([{ data: sData }]);
      })
      .catch((error) => {
        console.error("There was an error!", error);
      });
  }, []);

  return (
    <>
      <BarChart
        xAxis={[{ scaleType: "band", data: xAxisData }]}
        series={seriesData}
        width={1200}
        height={500}
        
      />
    </>
  );
}
export default OverView;
