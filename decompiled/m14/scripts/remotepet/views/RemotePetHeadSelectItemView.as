package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RemotePetHeadSelectItemView extends Component
   {
      
      private var _back:Image;
      
      private var _icon:BaseIconView;
      
      private var _level:FilterFrameText;
      
      private var _closeBtn:BaseButton;
      
      private var _data:PetData;
      
      public function RemotePetHeadSelectItemView()
      {
         super();
         initView();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadItemView.headBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadSelectItemView.levelTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetHeadSelectItemView.petIcon");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadSelectItemView.closeBtn");
         addChild(_back);
         addChild(_icon);
         addChild(_level);
         addChild(_closeBtn);
         _closeBtn.visible = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function showClose() : void
      {
         _closeBtn.visible = true;
      }
      
      public function set data(param1:PetData) : void
      {
         var _loc2_:String = null;
         _closeBtn.visible = false;
         _data = param1;
         if(_data)
         {
            _loc2_ = IconFactory.getPetHeadItemIcon(_data.templateId);
            if(_icon.icon != _loc2_)
            {
               _icon.icon = _loc2_;
            }
            this.tipData = _data;
         }
         else
         {
            _icon.icon = null;
            this.tipData = null;
         }
         _level.text = LanguageMgr.GetTranslation("public.level2",_data.grade);
         _level.setFrame(_data.quality);
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

