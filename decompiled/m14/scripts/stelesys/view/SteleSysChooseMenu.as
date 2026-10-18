package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysModel;
   
   public class SteleSysChooseMenu extends Sprite
   {
      
      public static const MENU_SWITCH:int = 1;
      
      public static const MENU_INTENSIFY:int = 2;
      
      public static const MENU_BACK:int = 3;
      
      private var _bg:MutipleImage;
      
      private var _switchTxt:FilterFrameText;
      
      private var _switchBtn:BaseButton;
      
      private var _switchView:StelesysSwitchView;
      
      private var _isMetral:Boolean;
      
      private var _sortObj:Array = [];
      
      private var _switchObj:StelaSwitchObj;
      
      public function SteleSysChooseMenu()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _switchObj = new StelaSwitchObj();
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.menuBg");
         _switchTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifydoTxt");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifyswitchBtn");
         _switchView = ComponentFactory.Instance.creatCustomObject("stelesys.StelesysSwitchView");
         addChild(_bg);
         addChild(_switchTxt);
         addChild(_switchBtn);
         addChild(_switchView);
         _switchView.switchFlg = false;
      }
      
      public function refreshSwitchMenuName(param1:String) : void
      {
         _switchTxt.text = getSwitchMenuName(param1);
         _switchView.refreshSwitchState(param1);
      }
      
      public function set menuType(param1:int) : void
      {
         _switchView.type = param1;
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      private function getSwitchMenuName(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc14_:String = null;
         _switchObj.reset();
         var _loc6_:Array = _switchObj.stars;
         var _loc8_:Array = _switchObj.colors;
         var _loc7_:Array = param1.split(",");
         var _loc2_:String = "";
         var _loc12_:String = _loc7_[0];
         var _loc9_:String = _loc7_[1];
         var _loc3_:int = int(_loc7_[2]);
         var _loc13_:Array = _loc12_.split("|");
         var _loc10_:Array = _loc9_.split("|");
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc4_ = int(_loc13_[_loc5_]);
            if(_loc4_ == 1)
            {
               if(_loc2_ == "")
               {
                  _loc2_ += LanguageMgr.GetTranslation("stela.check.star" + _loc5_);
               }
               else
               {
                  _loc2_ += "/" + LanguageMgr.GetTranslation("stela.check.star" + _loc5_);
               }
               _loc6_.push(["star",_loc5_ + 1]);
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc4_ = int(_loc10_[_loc5_]);
            if(_loc4_ == 1)
            {
               if(_loc2_ == "")
               {
                  _loc2_ += LanguageMgr.GetTranslation("stela.check.step" + _loc5_);
               }
               else
               {
                  _loc2_ += "/" + LanguageMgr.GetTranslation("stela.check.step" + _loc5_);
               }
               _loc8_.push(["stepColor",_loc5_ + 1]);
            }
            _loc5_++;
         }
         var _loc11_:int = 12;
         if(_loc2_.length >= _loc11_)
         {
            _loc14_ = _loc2_.substr(0,_loc11_);
            _loc2_ = _loc14_ = _loc14_ + "...";
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_switchTxt);
         _switchTxt = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_switchView);
         _switchView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         _switchBtn.addEventListener("click",switchViewHandler);
      }
      
      private function removeEvent() : void
      {
         _switchBtn.removeEventListener("click",switchViewHandler);
      }
      
      private function switchViewHandler(param1:MouseEvent) : void
      {
         _switchView.switchFlg = !_switchView.switchFlg;
      }
      
      public function get switchObj() : StelaSwitchObj
      {
         return _switchObj;
      }
   }
}

