import { Link, useLocation } from "react-router-dom";
import clsx from "clsx";
import styles from "./Sidebar.module.scss";

import Paper from "@mui/material/Paper";

function Sidebar() {
  const location = useLocation();

  return (
    <>
      <div className="row p-2">
        <img src="logo192.png" alt="logo" />
      </div>
      <nav className={styles.nav}>
        <ul className={styles.ul}>
          <li className={clsx(location.pathname === "/" && styles.active)}>
            <Link to="/" className={styles.link}>
              <div className={styles.item}>Dashboard</div>
            </Link>
          </li>
          <li className={clsx(location.pathname === "/dish" && styles.active)}>
            <Link to="/dish" className={styles.link}>
              <div className={styles.item}>
                <p>Món ăn</p>
              </div>
            </Link>
          </li>
          <li
            className={clsx(location.pathname === "/customer" && styles.active)}
          >
            <Link to="/customer" className={styles.link}>
              <div className={styles.item}>Khách hàng</div>
            </Link>
          </li>
          <li
            className={clsx(location.pathname === "/receipt" && styles.active)}
          >
            <Link to="/receipt" className={styles.link}>
              <div className={styles.item}>Hoá đơn</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/staffwaiter" && styles.active
            )}
          >
            <Link to="/staffwaiter" className={styles.link}>
              <div className={styles.item}>Nhân viên bàn</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/staffstore" && styles.active
            )}
          >
            <Link to="/staffstore" className={styles.link}>
              <div className={styles.item}>Nhân viên kho</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/receivednote" && styles.active
            )}
          >
            <Link to="/receivednote" className={styles.link}>
              <div className={styles.item}>Thông tin nhập kho</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/deliverynote" && styles.active
            )}
          >
            <Link to="/deliverynote" className={styles.link}>
              <div className={styles.item}>Thông tin xuất kho</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/store" && styles.active
            )}
          >
            <Link to="/store" className={styles.link}>
              <div className={styles.item}>Kho Nguyên Liệu</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/voucher" && styles.active
            )}
          >
            <Link to="/voucher" className={styles.link}>
              <div className={styles.item}>Voucher</div>
            </Link>
          </li>
          <li
            className={clsx(
              location.pathname === "/table" && styles.active
            )}
          >
            <Link to="/table" className={styles.link}>
              <div className={styles.item}>Bàn</div>
            </Link>
          </li>
        </ul>
      </nav>
      {/* <nav>
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
        </nav>  */}
    </>
  );
}
export default Sidebar;
