import { Routes, Route, Link } from "react-router-dom";

import GlobalStyles from "./pages/GlobalStyles";
import Manager from "./pages/Manager";

import Header from "./pages/Manager/components/Header";
import Sidebar from "./pages/Manager/components/Sidebar";
import Footer from "./pages/Manager/components/Footer";


import Dashboard from "./pages/Manager/Dashboard";
import Dish from "./pages/Manager/Dish";
import Customer from "./pages/Manager/Customer";
import Receipt from "./pages/Manager/Receipt";
import Staffwaiter from "./pages/Manager/Staffwaiter";
import Staffstore from "./pages/Manager/Staffstore";
import Receivednote from "./pages/Manager/Receivednote";
import Deliverynote from "./pages/Manager/Deliverynote";
import NotFound from "./pages/Manager/NotFound";

function App() {
  return (
    <GlobalStyles>
      <>

        <div className="container">
          <div className="row">
            <div className="col-3 border">
              <Sidebar />
            </div>
            <div className="col-9 ">
              <div className="row border">
                <Header />
              </div>
              <div className="row border">
                <Routes>
                  <Route path="/" element={<Dashboard />} />
                  <Route path="/dish" element={<Dish />} />
                  <Route path="/customer" element={<Customer />} />
                  <Route path="/receipt" element={<Receipt />} />
                  <Route path="/staffwaiter" element={<Staffwaiter />} />
                  <Route path="/staffstore" element={<Staffstore />} />
                  <Route path="/receivednote" element={<Receivednote />} />
                  <Route path="/deliverynote" element={<Deliverynote />} />
                </Routes>
              </div>
              <div className="row border">
                <Footer />
              </div>
            </div>
          </div>
        </div>
      </>
    </GlobalStyles>
  );
}

export default App;
