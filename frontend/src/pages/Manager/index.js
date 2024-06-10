import { Routes, Route, useMatch, Link } from "react-router-dom";
import style from "./Manager.module.scss";

import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import Footer from "./components/Footer";

import Dashboard from "./Dashboard";
import Dish from "./Dish";
import Customer from "./Customer";
import NotFound from "./NotFound";

function Manager() {
  return (
    <>
      <div>
        <nav>
          <ul>
            <li>
              <Link to="/">Dashboard</Link>
            </li>
            <li>
              <Link to="/manager/dish">Dish</Link>
            </li>
            <li>
              <Link to="/customer">Customer</Link>
            </li>
            
          </ul>
        </nav>
      </div>
      <div className="container">
        <div className="row">
          <div className="col-3 bg-primary">
            <Sidebar />
          </div>
          <div className="col-9 bg-secondary">
            <div className="row bg-danger">
              <Header />
            </div>
            <div className="row bg-warning">
              <Routes>
                <Route path="/manager/" element={<Dashboard />} />
                <Route path="/manager/dish" element={<Dish />} />
                <Route path="/manager/customer" element={<Customer />} />
              </Routes>
            </div>
            <div className="row">
              <Footer />
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default Manager;

