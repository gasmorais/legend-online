package childpve
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.RemotePetManager;
   import mvc.module.armyII.SkillInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.GoodsManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildPveSkillItemView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _icon:BaseIconView;
      
      private var _data:SkillInfo;
      
      private var _filter:IFilterFormat;
      
      public function ChildPveSkillItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("childpve.skillitem.skillIcon");
         addChild(_icon);
         _filter = new UIFilter();
      }
      
      private function initEvent() : void
      {
      }
      
      public function set data(param1:SkillInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            visible = false;
            return;
         }
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,41,41);
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _icon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icons);
         _icon.tipData = _data;
         checkCondition();
      }
      
      public function checkCondition() : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.grade == 0)
         {
            _filter.setGrayFilter(_icon);
         }
         if(_data.grade > 0)
         {
            _filter.setNormalFilter(_icon);
         }
      }
      
      private function checkCanAdd() : Boolean
      {
         if(_data.grade == 0)
         {
            return false;
         }
         if(!_data.nextTemplateInfo)
         {
            return false;
         }
         if(GoodsManager.instance.getGoodsNumByTempId(_data.nextTemplateInfo.UpgradeNeedItem) < _data.nextTemplateInfo.UpgradeNeedCount)
         {
            return false;
         }
         return true;
      }
      
      protected function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RemotePetManager.sendUpdateSkill(_data.templateId);
      }
      
      public function get data() : SkillInfo
      {
         return _data;
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

