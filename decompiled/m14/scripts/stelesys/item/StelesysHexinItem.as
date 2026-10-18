package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StelesysHexinItem extends StelesysBoxItem
   {
      
      protected var _btnSp:Sprite;
      
      protected var _btnBack:Bitmap;
      
      protected var _upBtn:BaseButton;
      
      protected var _downBtn:BaseButton;
      
      protected var _pos:int;
      
      public function StelesysHexinItem()
      {
         super();
         initEvent();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _btnSp = ComponentFactory.Instance.creatCustomObject("stelesys.main.hexiSp");
         _btnBack = ComponentFactory.Instance.creatBitmap("asset.stelesys.mian.opBtnBg");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.mainUpBtn");
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.mainDownBtn");
         addChild(_btnSp);
         _btnSp.addChild(_btnBack);
         _btnSp.addChild(_upBtn);
         _btnSp.addChild(_downBtn);
         _downBtn.visible = false;
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            _upBtn.visible = true;
            _downBtn.visible = false;
            tipData = null;
            return;
         }
         tipData = param1;
         _upBtn.visible = false;
         _downBtn.visible = true;
      }
      
      protected function initEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.addEventListener("click",doUpHandler);
         }
         if(_downBtn)
         {
            _downBtn.addEventListener("click",doDownHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",doUpHandler);
         }
         if(_downBtn)
         {
            _downBtn.removeEventListener("click",doDownHandler);
         }
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      protected function doUpHandler(param1:MouseEvent) : void
      {
         if(model.allStelaList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.switch.noTip"));
            return;
         }
         SteleSysManager.Ins.model.operPos = _pos;
         FrameControllerManager.instance.openControllerByInfo("stelesys","switch.page",1);
      }
      
      protected function doDownHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            SteleSysManager.Ins.sendEquip(0,_pos);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnBack);
         _btnBack = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_downBtn);
         _downBtn = null;
         ObjectUtils.disposeObject(_btnSp);
         _btnSp = null;
         super.dispose();
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
   }
}

