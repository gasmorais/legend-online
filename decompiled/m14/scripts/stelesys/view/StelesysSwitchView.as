package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   
   public class StelesysSwitchView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _resetBtn:IconButton;
      
      private var _confrimBtn:IconButton;
      
      private var _starList:Array = [];
      
      private var _profileList:Array = [];
      
      private var _type:int;
      
      private var _line:Image;
      
      private var _switchFlg:Boolean;
      
      private const SW_SIZE:int = 5;
      
      public function StelesysSwitchView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:SelectedCheckButton = null;
         var _loc5_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         _bg.width = 210;
         _bg.height = 290;
         var _loc2_:int = 15;
         var _loc6_:int = 20;
         var _loc4_:int = 95;
         var _loc3_:int = 31;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("stelesys.switchBtn");
            _loc8_.text = LanguageMgr.GetTranslation("stela.check.star" + _loc5_);
            _loc8_.selected = true;
            _loc1_ = _loc5_ % 2;
            _loc7_ = _loc5_ / 2;
            _loc8_.x = _loc2_ + _loc1_ * _loc4_;
            _loc8_.y = _loc6_ + _loc7_ * _loc3_;
            addChild(_loc8_);
            _starList[_loc5_] = _loc8_;
            _loc5_++;
         }
         _line = ComponentFactory.Instance.creatComponentByStylename("ui.stela.switchView.line");
         addChild(_line);
         _loc6_ = 140;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("stelesys.switchBtn");
            _loc8_.text = LanguageMgr.GetTranslation("stela.check.step" + _loc5_);
            _loc8_.selected = true;
            _loc1_ = _loc5_ % 2;
            _loc7_ = _loc5_ / 2;
            _loc8_.x = _loc2_ + _loc1_ * _loc4_;
            _loc8_.y = _loc6_ + _loc7_ * _loc3_;
            addChild(_loc8_);
            _profileList[_loc5_] = _loc8_;
            _loc5_++;
         }
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("stelesys.sort.restBtn");
         _confrimBtn = ComponentFactory.Instance.creatComponentByStylename("stelesys.sort.confirm");
         addChild(_resetBtn);
         addChild(_confrimBtn);
      }
      
      public function refreshSwitchState(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc5_:Array = param1.split(",");
         var _loc3_:int = 0;
         var _loc4_:Array = _loc5_[0].split("|");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = int(_loc4_[_loc3_]);
            _starList[_loc3_].selected = _loc2_ == 0 ? false : true;
            _loc3_++;
         }
         var _loc6_:Array = _loc5_[1].split("|");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = int(_loc6_[_loc3_]);
            _profileList[_loc3_].selected = _loc2_ == 0 ? false : true;
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         for each(_loc1_ in _starList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         for each(_loc1_ in _profileList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _starList = null;
         _profileList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_confrimBtn);
         _confrimBtn = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
      
      private function initEvent() : void
      {
         _resetBtn.addEventListener("click",resetHandler);
         _confrimBtn.addEventListener("click",confrimHandler);
      }
      
      private function removeEvent() : void
      {
         _resetBtn.removeEventListener("click",resetHandler);
         _confrimBtn.removeEventListener("click",confrimHandler);
      }
      
      private function resetHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = true;
         for each(_loc3_ in _starList)
         {
            _loc3_.selected = _loc2_;
         }
         for each(_loc3_ in _profileList)
         {
            _loc3_.selected = _loc2_;
         }
      }
      
      private function confrimHandler(param1:MouseEvent) : void
      {
         var _loc4_:SelectedCheckButton = null;
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = _starList[_loc3_];
            if(_loc4_.selected)
            {
               _loc2_ += "1|";
            }
            else
            {
               _loc2_ += "0|";
            }
            _loc3_++;
         }
         _loc2_ += ",";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = _profileList[_loc3_];
            if(_loc4_.selected)
            {
               _loc2_ += "1|";
            }
            else
            {
               _loc2_ += "0|";
            }
            _loc3_++;
         }
         switch(_type - 1)
         {
            case 0:
               SteleSysManager.Ins.model.currSwitchStr = _loc2_;
               break;
            case 1:
               SteleSysManager.Ins.model.currIntensifyStr = _loc2_;
               break;
            case 2:
               SteleSysManager.Ins.model.backStr = _loc2_;
         }
         switchFlg = false;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get switchFlg() : Boolean
      {
         return _switchFlg;
      }
      
      public function set switchFlg(param1:Boolean) : void
      {
         _switchFlg = param1;
         this.visible = _switchFlg;
      }
   }
}

