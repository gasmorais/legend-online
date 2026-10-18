package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.armyII.SkillInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class BraveLegSkillItemView extends Component
   {
      
      private var _title:ScaleFrameImage;
      
      private var _iconBg:Image;
      
      private var _icon:BaseIconView;
      
      private var _data:Object;
      
      public function BraveLegSkillItemView()
      {
         super();
         initView();
         mouseChildren = false;
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillTitle");
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillIconBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillIcon");
         addChild(_title);
         addChild(_iconBg);
         addChild(_icon);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:SkillInfo = null;
         _data = param1;
         if(_data)
         {
            _title.visible = true;
            _icon.visible = true;
            _title.setFrame(BraveLegSkillSelectView.SKILL.indexOf(_data.MasterType) + 1);
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _loc2_ = new SkillInfo();
            _loc2_.templateId = _data.TemplateId;
            _loc2_.grade = _data.Grades;
            this.tipData = _loc2_;
         }
         else
         {
            _title.visible = false;
            _icon.visible = false;
            this.tipData = null;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _data = null;
         super.dispose();
      }
   }
}

