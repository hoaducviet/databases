import { Link } from "react-router-dom";
import AccountMenu from './AccountMenu';
import Notification from './Notification';

function Header() {
  return (
    <>
    <div className="row p-3">
        <div className="col-1">
            <Notification />
        </div>
        <div className="col-10">
            
        </div>
        <div className="col-1">
            <AccountMenu />
        </div>
    </div>
      
    </>
  );
}
export default Header;
