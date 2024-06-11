import { Routes, Route, useMatch, Link } from "react-router-dom";
import clsx from "clsx";
import styles from "./Manager.module.scss";

import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import Footer from "./components/Footer";

import Dashboard from "./Dashboard";
import Dish from "./Dish";
import Customer from "./Customer";
import Receipt from "./Receipt";
import Staffwaiter from "./Staffwaiter";
import Staffstore from "./Staffstore";
import Receivednote from "./Receivednote";
import Deliverynote from "./Deliverynote";
import Store from "./Store";
import NotFound from "./NotFound";
import Paper from '@mui/material/Paper';

function Manager() {
  return (
    <>
      <div className={styles.containerContent}>
        <div className="container-fluid" style={{ padding: 20 }}>
          <div className="row">
            <div className="col-2 border-end">
              <div className={styles.sidebarContent}>
                <Sidebar />
              </div>
            </div>
            <div className="col-10 ">
              <div className="row ">
              <Paper>
                <Header />
              </Paper>
              </div>
              <div className="row p-5">
                <div className={styles.mainContent}>
                  <Routes>
                    <Route path="/" element={<Dashboard />} />
                    <Route path="/dish" element={<Dish />} />
                    <Route path="/customer" element={<Customer />} />
                    <Route path="/receipt" element={<Receipt />} />
                    <Route path="/staffwaiter" element={<Staffwaiter />} />
                    <Route path="/staffstore" element={<Staffstore />} />
                    <Route path="/receivednote" element={<Receivednote />} />
                    <Route path="/deliverynote" element={<Deliverynote />} />
                    <Route path="/store" element={<Store />} />
                  </Routes>
                </div>
              </div>
              <div className="row">
                <Footer />
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default Manager;
