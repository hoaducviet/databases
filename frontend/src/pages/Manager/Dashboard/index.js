import RecentTransaction from "./RecentTransaction";
import TopDishNumber from "./TopDishNumber";
import TopDishRate from "./TopDishRate";
import OverView from "./Overview";
import YearlyBreakup from "./YearlyBreakup";
import MonthlyEarnigs from "./MonthlyEarnigs";

import Paper from '@mui/material/Paper';

function Dashboard() {
  
  
  return (
    <>
      <div className="row">
       
            <h2>Doanh thu 7 ngày gần nhất</h2>
          <OverView />
      </div>
      <div className="row p-3">
        <h2>Top món ăn bán chạy nhất</h2>
          <TopDishNumber />
      </div>
      <div className="row p-3">
        <TopDishRate />
      </div>
    </>
  );
}

export default Dashboard;

// <div className="row">
//         <div className="col-8 border">
//           <OverView />
//         </div>
//         <div className="col-4">
//           <div className="row">
//             <YearlyBreakup />
//           </div>
//           <div className="row">
//             <MonthlyEarnigs />
//           </div>
//         </div>
//       </div>
//       <div className="row">
//         <div className="col-4">
//           <RecentTransaction />
//         </div>
//         <div className="col-8">
//           <TopDishNumber />
//         </div>
//       </div>
//       <div className="row">
//         <TopDishRate />
//       </div>