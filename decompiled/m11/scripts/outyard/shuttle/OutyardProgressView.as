package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import yishi.manager.OutyardManager;
   
   public class OutyardProgressView extends Component
   {
      
      private var _progressBg:Bitmap;
      
      private var _progressBar:MovieClip;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      private var _discountList:Array = [];
      
      private var _perPage:int = 5;
      
      private var _progressArr:Array = [17,35,50,65,85];
      
      public function OutyardProgressView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OutyardProgressChest = null;
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.progress.leftArrow");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.progress.rightArrow");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.outyard.ShuttleScoreBg");
         _progressBar = ComponentFactory.Instance.creatCustomObject("outyard.ShuttleScoreBar");
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_progressBg);
         addChild(_progressBar);
         _progressBar.gotoAndStop(50);
         _goodList = [];
         _loc2_ = 0;
         while(_loc2_ < _perPage)
         {
            _loc1_ = new OutyardProgressChest();
            _loc1_.x = _loc2_ * 110 + 70;
            addChild(_loc1_);
            _goodList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         _discountList = OutyardManager.instance.shuttleModel.chestList;
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _discountList.length)
         {
            _discountList[_loc2_].Index = _loc2_;
            _discountList[_loc2_].RewardState = _loc1_.rewardState[_loc2_];
            _loc2_++;
         }
         if(_loc1_.op == 6)
         {
            _currentPage = 1;
         }
         updateView();
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _countGood = 0;
         if(_discountList.length % _perPage != 0 || _discountList.length == 0)
         {
            _totalPage = _discountList.length / _perPage + 1;
         }
         else
         {
            _totalPage = _discountList.length / _perPage;
         }
         _loc2_ = 0;
         while(_loc2_ < _perPage)
         {
            if(_currentPage - 1 < 0)
            {
               _loc1_ = _loc2_;
            }
            else
            {
               _loc1_ = _loc2_ + (_currentPage - 1) * _perPage;
            }
            if(_discountList.length > _loc1_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc2_].data = _discountList[_loc1_];
            }
            else
            {
               _goodList[_loc2_].data = null;
            }
            _loc2_++;
         }
         updatePageView();
         updateProgressBar();
      }
      
      private function updatePageView() : void
      {
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      private function updateProgressBar() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         _progressBar.gotoAndStop(1);
         _loc4_ = 0;
         while(_loc4_ < _perPage)
         {
            if(_currentPage - 1 < 0)
            {
               _loc3_ = _loc4_;
            }
            else
            {
               _loc3_ = _loc4_ + (_currentPage - 1) * _perPage;
            }
            if(_discountList.length > _loc3_)
            {
               _loc2_ = int(_discountList[_loc3_].ShuttleScore);
               if(_loc1_.shuttleScore >= _loc2_)
               {
                  _progressBar.gotoAndStop(_progressArr[_loc4_]);
               }
            }
            _loc4_++;
         }
         if(_discountList[_loc3_ + 1])
         {
            _loc2_ = int(_discountList[_loc3_ + 1].ShuttleScore);
            if(_loc1_.shuttleScore >= _loc2_)
            {
               _progressBar.gotoAndStop(100);
            }
         }
         if(_loc1_.shuttleScore >= OutyardManager.instance.shuttleModel.maxShuttleScore)
         {
            _progressBar.gotoAndStop(100);
         }
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeViolentMc(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         if(_goodList)
         {
            while(_goodList.length)
            {
               ObjectUtils.disposeObject(_goodList.pop());
            }
            _goodList = null;
         }
         _discountList = null;
         _progressArr = null;
         super.dispose();
      }
   }
}

