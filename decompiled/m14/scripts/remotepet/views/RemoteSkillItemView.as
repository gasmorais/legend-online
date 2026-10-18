package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.RemotePetManager;
   import mvc.module.armyII.SkillInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.GoodsManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RemoteSkillItemView extends Sprite implements Disposeable
   {
      
      private var _skillBack:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _levelTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _data:SkillInfo;
      
      private var _filter:IFilterFormat;
      
      public function RemoteSkillItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBack = ComponentFactory.Instance.creatComponentByStylename("remotepet.views.skillBack");
         _icon = ComponentFactory.Instance.creatCustomObject("remotepet.views.skillIcon");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.views.leveltxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.views.addBtn");
         _addBtn.visible = false;
         addChild(_skillBack);
         addChild(_icon);
         addChild(_levelTxt);
         addChild(_addBtn);
         _filter = new UIFilter();
      }
      
      private function initEvent() : void
      {
         _addBtn.addEventListener("click",__addHandler);
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
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _levelTxt.text = _data.templateInfo.Grades + "/" + _data.remotePetMaxGrade;
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
         _levelTxt.visible = true;
         _filter.setNormalFilter(_skillBack);
         if(checkCanAdd())
         {
            _filter.setNormalFilter(_icon);
            _addBtn.visible = true;
         }
         else
         {
            _filter.setGrayFilter(_icon);
            _addBtn.visible = false;
         }
         if(_data.grade == 0)
         {
            _levelTxt.visible = false;
            _filter.setGrayFilter(_skillBack);
            _filter.setGrayFilter(_icon);
            _addBtn.visible = false;
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
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         _data = null;
         _filter = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

