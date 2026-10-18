package areslords.skill
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AresLordsSkillItemView extends Component implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      public function AresLordsSkillItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameSkillBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameSkillIcon");
         addChild(_bg);
         addChild(_icon);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         super.dispose();
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc2_:SkillInfo = null;
         if(param1)
         {
            addChild(_bg);
            addChild(_icon);
            _loc2_ = new SkillInfo();
            _loc2_.templateId = param1.TemplateId;
            _icon.icon = IconFactory.getTecIconByIcon(_loc2_.templateInfo.Icons);
            _icon.tipData = _loc2_;
         }
         else
         {
            ObjectUtils.removeFromParent(_bg);
            ObjectUtils.removeFromParent(_icon);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,64,64);
      }
   }
}

