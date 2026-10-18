package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import flash.events.MouseEvent;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanIconItemView extends Component
   {
      
      private var _data:DragonTitanTempInfo;
      
      private var _titanId:int;
      
      private var _skillBg1:Image;
      
      private var _icon:BaseIconView;
      
      public function DragonTitanIconItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBg1 = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillBg1");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanIconItemView.icon");
         addChild(_skillBg1);
         addChild(_icon);
      }
      
      public function set data(param1:DragonTitanTempInfo) : void
      {
         if(!param1)
         {
            if(_icon)
            {
               _icon.icon = null;
            }
            this.tipData = null;
            _data = null;
            return;
         }
         _data = param1;
         this.tipData = _data.TemplateId;
         this.tipStyle = "yishi.view.tips.DragonTitanTips";
         this.isFollowMouse = false;
         this.tipDirctions = "4,5,6,0,1,2,3,7";
         if(_icon)
         {
            _icon.icon = IconFactory.getCommonIconPath(_data.AvatarPath);
         }
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function unInitView() : void
      {
         if(_skillBg1)
         {
            _skillBg1.dispose();
         }
         _skillBg1 = null;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         this.dispatchEvent(new MouseEvent("rollOut"));
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      public function get titanId() : int
      {
         return _titanId;
      }
      
      public function set titanId(param1:int) : void
      {
         _titanId = param1;
      }
   }
}

