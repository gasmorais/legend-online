package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.filter.UIFilter;
   
   public class TimeVortexDragonItemView extends Component
   {
      
      private var _overBack:Bitmap;
      
      private var _backBg:Bitmap;
      
      private var _type:int;
      
      private var _isOpen:Boolean;
      
      private var _isClick:Boolean;
      
      private var _powrs:Array = [0,20,40,60,80,100];
      
      private var _ui:UIFilter;
      
      public function TimeVortexDragonItemView(param1:int)
      {
         _type = param1;
         super();
         initView();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _overBack = ComponentFactory.Instance.creatBitmap("asset.timevortex.dragonBtnItemBack");
         _backBg = ComponentFactory.Instance.creatBitmap("asset.timevortex.dragonBtnItem0" + _type);
         addChild(_overBack);
         addChild(_backBg);
         _overBack.visible = false;
         _ui = new UIFilter();
         if(_type == 0)
         {
            this.tipData = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TipsTxt05");
         }
         else
         {
            this.tipData = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TipsTxt04",_powrs[_type]);
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(_isOpen)
         {
            _ui.setNormalFilter(_backBg);
         }
         else
         {
            _ui.setGrayFilter(_backBg);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_overBack);
         _overBack = null;
         ObjectUtils.disposeObject(_backBg);
         _backBg = null;
         _ui = null;
         super.dispose();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get isClick() : Boolean
      {
         return _isClick;
      }
      
      public function set isClick(param1:Boolean) : void
      {
         _isClick = param1;
         _overBack.visible = _isClick;
      }
   }
}

