package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetSkillItemView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _lock:Bitmap;
      
      protected var _filter:IFilterFormat;
      
      private var _tipIcon:ScaleFrameImage;
      
      private var _data:SkillTempInfo;
      
      public function PetSkillItemView()
      {
         super();
         _filter = new UIFilter();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.pet.ItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("pet.MorphSkillIcon");
         _lock = ComponentFactory.Instance.creat("asset.pet.ItemLock");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("petskill.SkillIconBack");
         _tipIcon.mouseEnabled = false;
         addChild(_back);
         addChild(_icon);
         addChild(_lock);
         addChild(_tipIcon);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_filter)
         {
            _filter.setLightingFilter(this);
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_filter)
         {
            _filter.setNormalFilter(this);
         }
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(_data)
         {
            addEvent();
            _icon.tipData = _data;
            _loc2_ = IconFactory.getCommonIconPath(_data.Icons);
            if(_icon.icon != _loc2_)
            {
               _icon.icon = _loc2_;
            }
            _lock.visible = false;
            _icon.visible = true;
            if(_data.UseWay == 2)
            {
               _tipIcon.visible = true;
            }
            else
            {
               _tipIcon.visible = false;
            }
         }
         else
         {
            removeEvent();
            _lock.visible = true;
            _icon.icon = null;
            _icon.visible = false;
            _icon.tipData = null;
            _tipIcon.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

