package bag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class RentalBagStateView extends Sprite implements Disposeable
   {
      
      private var _lock:Bitmap;
      
      private var _bg:Bitmap;
      
      protected var _overdueTip:Bitmap;
      
      protected var _overdueTxt:FilterFrameText;
      
      private var _openBtn:IconButton;
      
      protected var _continueBtn:IconButton;
      
      protected var _playerInfo:PlayerInfo;
      
      private var _currentPage:int;
      
      public function RentalBagStateView()
      {
         super();
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         initView();
         addEvent();
         refresh();
      }
      
      protected function initView() : void
      {
         _lock = ComponentFactory.Instance.creatBitmap("asset.core.RentalBagLock");
         _bg = ComponentFactory.Instance.creatBitmap("asset.core.RentalBagStateBg");
         _overdueTip = ComponentFactory.Instance.creatBitmap("asset.core.RentalBagOverdueTip");
         _overdueTxt = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagOverdueTxt");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagOpenBtn");
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagContinueBtn");
         addChild(_lock);
         addChild(_bg);
         addChild(_overdueTip);
         addChild(_overdueTxt);
         addChild(_openBtn);
         addChild(_continueBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overdueTip);
         _overdueTip = null;
         ObjectUtils.disposeObject(_overdueTxt);
         _overdueTxt = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_continueBtn);
         _continueBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         if(_playerInfo != null)
         {
            _playerInfo.addEventListener("RENTAL_BAG_TIME_REFRESH",__rentalBagStatusRefreshHandler);
         }
         if(_openBtn != null)
         {
            _openBtn.addEventListener("click",__openBtnClickHandler);
         }
         if(_continueBtn != null)
         {
            _continueBtn.addEventListener("click",__continueBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_playerInfo != null)
         {
            _playerInfo.removeEventListener("RENTAL_BAG_TIME_REFRESH",__rentalBagStatusRefreshHandler);
         }
         if(_openBtn != null)
         {
            _openBtn.removeEventListener("click",__openBtnClickHandler);
         }
         if(_continueBtn != null)
         {
            _continueBtn.removeEventListener("click",__continueBtnClickHandler);
         }
      }
      
      protected function __openBtnClickHandler(param1:MouseEvent) : void
      {
         showTips(1);
      }
      
      private function __continueBtnClickHandler(param1:MouseEvent) : void
      {
         showTips(2);
      }
      
      protected function showTips(param1:int) : void
      {
         var _loc2_:String = null;
         if(_playerInfo.bagTotalCount < 224)
         {
            _loc2_ = LanguageMgr.GetTranslation("bag.view.RentalBagStateView.OpenBtn.TipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:RentalBagAlertFrame = ComponentFactory.Instance.creatComponentByStylename("bag.view.RentalBagAlertFrame");
         _loc3_.type = param1;
         _loc3_.show();
      }
      
      private function __rentalBagStatusRefreshHandler(param1:PlayerEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:Date = null;
         if(_playerInfo.rentalBagStatus > 0)
         {
            _loc1_ = DateFormatter.parse(_playerInfo.rentalBagTime,"YYYY-MM-DD hh:mm:ss");
            _overdueTxt.text = DateFormatter.format(_loc1_,"YYYY-MM-DD");
            _openBtn.visible = false;
            _lock.visible = false;
            _overdueTip.visible = true;
            _overdueTxt.visible = true;
            _continueBtn.visible = true;
            if(_playerInfo.rentalBagStatus == 1 && currentPage == 6)
            {
               _lock.visible = true;
            }
         }
         else
         {
            _openBtn.visible = true;
            _lock.visible = true;
            _overdueTip.visible = false;
            _overdueTxt.visible = false;
            _continueBtn.visible = false;
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
      
      private function get model() : ArmyModel
      {
         return controller.model;
      }
      
      private function get controller() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

