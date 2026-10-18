package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetNormalSkillItemView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _maskShape:Shape;
      
      protected var _filter:IFilterFormat;
      
      private var _data:SkillTempInfo;
      
      public function PetNormalSkillItemView()
      {
         super();
         _filter = new UIFilter();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.NormalSkillBack");
         _icon = ComponentFactory.Instance.creatCustomObject("pet.NormalSkillIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("pet.NormalSkillName");
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(0);
         _maskShape.graphics.drawCircle(0,0,13);
         _maskShape.graphics.endFill();
         _icon.mask = _maskShape;
         _maskShape.x = _maskShape.y = 16;
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_maskShape);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
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
            _nameTxt.text = "";
            _icon.tipData = _data;
            _loc2_ = IconFactory.getCommonIconPath(_data.Icons);
            if(_icon.icon != _loc2_)
            {
               _icon.icon = _loc2_;
            }
            _icon.visible = true;
         }
         else
         {
            removeEvent();
            _nameTxt.text = "";
            _icon.icon = null;
            _icon.tipData = null;
            _icon.visible = false;
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

