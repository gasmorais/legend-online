package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanIconItemView extends Component
   {
      
      private var _data:Object;
      
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
      
      public function set data(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         this.tipData = _data.livingId;
         this.tipStyle = "yishi.view.tips.DragonTitanFightingTips";
         this.isFollowMouse = false;
         this.tipDirctions = "2,1";
         var _loc2_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(_data.titanId);
         if(_icon && _loc2_)
         {
            _icon.icon = IconFactory.getCommonIconPath(_loc2_.AvatarPath);
         }
      }
      
      override public function get width() : Number
      {
         return 67;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function unInitView() : void
      {
         if(_skillBg1)
         {
            ObjectUtils.disposeObject(_skillBg1);
         }
         _skillBg1 = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
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
         ShowTipManager.Instance.hideTip(this);
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

