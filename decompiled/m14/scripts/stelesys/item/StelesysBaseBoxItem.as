package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.stele.StelesysInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class StelesysBaseBoxItem extends Component
   {
      
      protected var _scaleSp:Sprite;
      
      protected var _boxBg:ScaleFrameImage;
      
      protected var _icon:BaseIconView;
      
      protected var _data:StelesysInfo;
      
      protected var _isEvt:Boolean;
      
      public function StelesysBaseBoxItem()
      {
         super();
         initView();
      }
      
      protected function addEvent() : void
      {
         _isEvt = true;
         this.addEventListener("rollOut",_outHander);
         this.addEventListener("rollOver",_overHandler);
      }
      
      protected function delEvent() : void
      {
         _isEvt = false;
         this.removeEventListener("rollOut",_outHander);
         this.removeEventListener("rollOver",_overHandler);
      }
      
      protected function _outHander(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
      }
      
      protected function _overHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
      }
      
      public function get data() : StelesysInfo
      {
         return _data;
      }
      
      public function set data(param1:StelesysInfo) : void
      {
         _data = param1;
         if(param1 == null)
         {
            delEvent();
            return;
         }
         if(!_isEvt)
         {
            addEvent();
         }
         _icon.icon = IconFactory.getStelaIcon(_data.tempInfo.Icon);
      }
      
      protected function initView() : void
      {
         _scaleSp = new Sprite();
         _boxBg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.boxBg");
         _icon = ComponentFactory.Instance.creatCustomObject("stelesys.icon");
         addChild(_scaleSp);
         _scaleSp.addChild(_boxBg);
         _scaleSp.addChild(_icon);
         _boxBg.setFrame(1);
      }
      
      public function doRemoveSelf() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_data)
         {
            _data.isChoose = false;
            _data.tempUse = 0;
         }
      }
      
      public function opUpdate() : void
      {
      }
      
      override public function dispose() : void
      {
         delEvent();
         ObjectUtils.disposeObject(_boxBg);
         _boxBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_scaleSp);
         _scaleSp = null;
         super.dispose();
         if(_data)
         {
            _data.isChoose = false;
         }
         _data = null;
      }
   }
}

