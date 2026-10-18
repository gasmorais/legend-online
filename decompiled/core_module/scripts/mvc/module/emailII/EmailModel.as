package mvc.module.emailII
{
   import events.EmailEvent;
   import flash.events.EventDispatcher;
   import yishi.manager.EmailManager;
   
   public class EmailModel extends EventDispatcher
   {
      
      public static const UNREAD_YEAR:int = 2999;
      
      public static const READ_MAIL:int = 1;
      
      public static const WRITE_MAIL_NEEDED_GOLD:int = 100;
      
      public static const WRITE_MAIL_MAX_LINES:int = 7;
      
      private var _pageCapicity:int = 6;
      
      private var _readState:int = 0;
      
      private var _emailType:int = 1;
      
      private var _currentPage:int = 1;
      
      private var _allSelected:Boolean;
      
      private var _totalPage:int = 1;
      
      private var _currentReadEmail:EmailInfo;
      
      private var _currentSelectedList:Array;
      
      private var _cate:EmailCategory;
      
      public var reply:String;
      
      public var selectedMailId:int;
      
      public function EmailModel()
      {
         super();
         _currentSelectedList = [];
         _totalPage = calcTotalPage;
         EmailManager.instance.addEventListener("DATA_EMAIL_DELETE",__deleteDataHandler);
         EmailManager.instance.addEventListener("DATA_EMAIL_UPDATE",__updateHandler);
      }
      
      private function __deleteDataHandler(param1:EmailEvent) : void
      {
         _totalPage = calcTotalPage;
         dispatchEvent(new EmailEvent("DATA_EMAIL_DELETE",null,param1.list));
      }
      
      private function __updateHandler(param1:EmailEvent) : void
      {
         dispatchEvent(new EmailEvent("DATA_EMAIL_UPDATE",null,param1.list));
      }
      
      public function get emailType() : int
      {
         return _emailType;
      }
      
      public function set emailType(param1:int) : void
      {
         _emailType = param1;
         calcTotalPage;
         dispatchEvent(new EmailEvent("VIEW_EMAILTYPE_CHANGE"));
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
         dispatchEvent(new EmailEvent("VIEW_PAGE_CHANGE"));
      }
      
      public function get allSelected() : Boolean
      {
         if(currentSelectedList.length == 0)
         {
            _allSelected = false;
         }
         return _allSelected;
      }
      
      public function set allSelected(param1:Boolean) : void
      {
         _allSelected = param1;
         _currentSelectedList.length = 0;
         if(_allSelected)
         {
            for each(var _loc2_:EmailInfo in currentViewList)
            {
               _currentSelectedList.push(_loc2_.Id);
            }
         }
         dispatchEvent(new EmailEvent("VIEW_ALL_SELECTED"));
      }
      
      public function get calcTotalPage() : int
      {
         var _loc1_:Array = EmailManager.instance.getListByType(emailType);
         _totalPage = (_loc1_.length + (_pageCapicity - 1)) / _pageCapicity;
         if(_totalPage == 0)
         {
            _totalPage = 1;
         }
         if(_currentPage > _totalPage)
         {
            _currentPage = _totalPage;
         }
         return _totalPage;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         _totalPage = param1;
      }
      
      public function get currentReadEmail() : EmailInfo
      {
         return _currentReadEmail;
      }
      
      public function set currentReadEmail(param1:EmailInfo) : void
      {
         if(param1 != _currentReadEmail)
         {
            _currentReadEmail = param1;
            dispatchEvent(new EmailEvent("VIEW_CURRENTREAD_CHANGE"));
         }
      }
      
      public function get currentViewList() : Array
      {
         var _loc3_:Array = EmailManager.instance.getListByType(emailType);
         var _loc2_:int = (_currentPage - 1) * _pageCapicity;
         var _loc1_:int = _loc3_.length - _loc2_;
         if(_loc1_ >= _pageCapicity)
         {
            return _loc3_.slice(_loc2_,_loc2_ + _pageCapicity);
         }
         return _loc3_.slice(_loc2_,_loc2_ + _loc1_);
      }
      
      public function get currentSelectedList() : Array
      {
         return _currentSelectedList;
      }
      
      public function addSelected(param1:int) : void
      {
         _currentSelectedList.push(param1);
      }
      
      public function deleteSelected(param1:int) : void
      {
         var _loc2_:int = _currentSelectedList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _currentSelectedList.splice(_loc2_,1);
         }
      }
      
      public function deleteSelectedAll() : void
      {
         _currentSelectedList = [];
         selectedMailId = 0;
         currentReadEmail = null;
      }
   }
}

