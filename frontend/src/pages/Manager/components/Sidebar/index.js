import { Link } from "react-router-dom";
import clsx from 'clsx'
import styles from  "./Sidebar.module.scss";

function Sidebar() {
  return (
    <>
      <nav>
          <ul>
            <li>
              <Link to="/">Dashboard</Link>
            </li>
            <li>
              <Link to="/dish">Món ăn</Link>
            </li>
            <li>
              <Link to="/customer">Khách hàng</Link>
            </li>
            <li>
              <Link to="/receipt">Hoá đơn</Link>
            </li>
            <li>
              <Link to="/staffwaiter">Nhân viên bàn</Link>
            </li>
            <li>
              <Link to="/staffstore">Nhân viên kho</Link>
            </li>
            <li>
              <Link to="/receivednote">Thông tin nhập kho</Link>
            </li>
            <li>
              <Link to="/deliverynote">Thông tin xuất kho</Link>
            </li>

            
          </ul>
        </nav> 
    </>
  );
}
export default Sidebar;
