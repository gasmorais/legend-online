package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   
   public class StelesysSortView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _tabG1:SelectedButtonGroup;
      
      private var _tabG2:SelectedButtonGroup;
      
      private var _confrimBtn:IconButton;
      
      private var _line:Image;
      
      private var _sortFlg:Boolean;
      
      private var _type:int;
      
      public function StelesysSortView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc8_:SelectedIconTextButton = null;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         _bg.width = 210;
         _bg.height = 270;
         _tabG1 = new SelectedButtonGroup();
         var _loc2_:int = 20;
         var _loc6_:int = 20;
         var _loc4_:int = 100;
         var _loc3_:int = 31;
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("stelesys.gBtn");
            _loc8_.text = LanguageMgr.GetTranslation("stela.sort.a" + _loc5_);
            _tabG1.addSelectItem(_loc8_);
            addChild(_loc8_);
            _loc1_ = _loc5_ % 2;
            _loc7_ = _loc5_ / 2;
            _loc8_.x = _loc2_ + _loc1_ * _loc4_;
            _loc8_.y = _loc6_ + _loc7_ * _loc3_;
            _loc5_++;
         }
         _tabG1.selectIndex = 0;
         _line = ComponentFactory.Instance.creatComponentByStylename("ui.stela.sortView.line");
         addChild(_line);
         _loc6_ = 65;
         _tabG2 = new SelectedButtonGroup();
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("stelesys.gBtn");
            _loc8_.text = LanguageMgr.GetTranslation("stela.sort.b" + _loc5_);
            _tabG2.addSelectItem(_loc8_);
            addChild(_loc8_);
            _loc1_ = _loc5_ % 2;
            _loc7_ = _loc5_ / 2;
            _loc8_.x = _loc2_ + _loc1_ * _loc4_;
            _loc8_.y = _loc6_ + _loc7_ * _loc3_;
            _loc5_++;
         }
         _tabG2.selectIndex = 0;
         _confrimBtn = ComponentFactory.Instance.creatComponentByStylename("stelesys.sort.confirm");
         addChild(_confrimBtn);
         _confrimBtn.x = 57;
         _confrimBtn.y = 217;
      }
      
      private function initEvent() : void
      {
         _confrimBtn.addEventListener("click",confrimHandler);
      }
      
      private function removeEvent() : void
      {
         _confrimBtn.removeEventListener("click",confrimHandler);
      }
      
      private function confrimHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = _tabG1.selectIndex + "|" + _tabG2.selectIndex;
         switch(_type - 1)
         {
            case 0:
            case 1:
         }
         sortFlg = false;
      }
      
      public function refreshSortState(param1:String) : void
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split("|");
            _tabG1.selectIndex = int(_loc2_[0]);
            _tabG2.selectIndex = int(_loc2_[1]);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tabG1);
         _tabG1 = null;
         ObjectUtils.disposeObject(_tabG2);
         _tabG2 = null;
         ObjectUtils.disposeObject(_confrimBtn);
         _confrimBtn = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
      
      public function get sortFlg() : Boolean
      {
         return _sortFlg;
      }
      
      public function set sortFlg(param1:Boolean) : void
      {
         _sortFlg = param1;
         this.visible = _sortFlg;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
   }
}

