package consortia.view.myConsortia.building
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaRentalBagStateView extends Sprite implements Disposeable
   {
      
      private var _lock:Bitmap;
      
      private var _bg:Bitmap;
      
      protected var _overdueTip:Bitmap;
      
      protected var _overdueTxt:FilterFrameText;
      
      private var _openBtn:IconButton;
      
      protected var _continueBtn:IconButton;
      
      private var _data:ConsortiaModel;
      
      private var _currentPage:int;
      
      private var _tip2:Bitmap;
      
      private var _delayRental:Boolean;
      
      public function ConsortiaRentalBagStateView()
      {
         super();
         _data = FrameControllerManager.instance.consortiaController.model;
         initView();
         addEvent();
         refresh();
      }
      
      protected function initView() : void
      {
         _lock = ComponentFactory.Instance.creatBitmap("asset.core.RentalBagLock");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.RentalBagStateBg");
         _overdueTip = ComponentFactory.Instance.creatBitmap("asset.core.RentalBagOverdueTip");
         _overdueTxt = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagOverdueTxt");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagOpenBtn");
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("core.RentalBagContinueBtn");
         _tip2 = ComponentFactory.Instance.creatBitmap("asset.consortia.caseTips2");
         addChild(_lock);
         addChild(_bg);
         addChild(_overdueTip);
         addChild(_overdueTxt);
         addChild(_openBtn);
         addChild(_continueBtn);
         addChild(_tip2);
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
         ObjectUtils.disposeObject(_tip2);
         _tip2 = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         if(_openBtn != null)
         {
            _openBtn.addEventListener("click",__openBtnClickHandler);
         }
         if(_continueBtn != null)
         {
            _continueBtn.addEventListener("click",__continueBtnClickHandler);
         }
         _data.addEventListener("UPDA_CONSORTIA_INFO",__rentalBagStatusRefreshHandler);
      }
      
      private function removeEvent() : void
      {
         if(_openBtn != null)
         {
            _openBtn.removeEventListener("click",__openBtnClickHandler);
         }
         if(_continueBtn != null)
         {
            _continueBtn.removeEventListener("click",__continueBtnClickHandler);
         }
         _data.removeEventListener("UPDA_CONSORTIA_INFO",__rentalBagStatusRefreshHandler);
      }
      
      protected function __openBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkClick())
         {
            return;
         }
         showTips(1);
      }
      
      private function __continueBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkClick())
         {
            return;
         }
         showTips(2);
      }
      
      protected function showTips(param1:int) : void
      {
         var _loc2_:ConsortiaRentalBagAlertFrame = ComponentFactory.Instance.creatComponentByStylename("bag.view.ConsortiaRentalBagAlertFrame");
         _loc2_.currentPage = currentPage;
         _loc2_.type = param1;
         _loc2_.show();
      }
      
      private function checkClick() : Boolean
      {
         if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.chairmanID != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("building.ConsortiaRentalBagStateView.notMaster"));
            return false;
         }
         var _loc1_:int = int(FrameControllerManager.instance.consortiaController.model.consortiaInfo.storeLevel);
         if(_loc1_ < 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("building.ConsortiaRentalBagStateView.lessTenLevel"));
            return false;
         }
         return true;
      }
      
      private function __rentalBagStatusRefreshHandler(param1:ConsortiaEvent) : void
      {
         refresh();
      }
      
      public function set delayRental(param1:Boolean) : void
      {
         _delayRental = param1;
      }
      
      public function refresh() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc1_:Date = null;
         if(currentPage == 2)
         {
            _loc2_ = Boolean(_data.consortiaInfo.isStorageExpire1);
            _loc3_ = _data.consortiaInfo.storageExpireTime1;
         }
         else if(currentPage == 3)
         {
            _loc2_ = Boolean(_data.consortiaInfo.isStorageExpire2);
            _loc3_ = _data.consortiaInfo.storageExpireTime2;
         }
         if(!_loc2_ || _delayRental)
         {
            _loc1_ = DateFormatter.parse(_loc3_,"YYYY-MM-DD hh:mm:ss");
            _overdueTxt.text = DateFormatter.format(_loc1_,"YYYY-MM-DD");
            _openBtn.visible = false;
            _lock.visible = false;
            _overdueTip.visible = true;
            _overdueTxt.visible = true;
            _continueBtn.visible = true;
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
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

