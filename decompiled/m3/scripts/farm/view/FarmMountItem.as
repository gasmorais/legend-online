package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.ShowMountMsgInfo;
   import flash.events.MouseEvent;
   import funny.mountact.MountsAvatarView;
   import yishi.datas.templates.MountTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.view.base.StarBar;
   
   public class FarmMountItem extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _mount:MountsAvatarView;
      
      private var _filter:UIFilter;
      
      private var _mountTempId:int;
      
      private var _tipView:FarmMountSelectMenu;
      
      private var _data:ShowMountMsgInfo;
      
      public var pos:int;
      
      private var _cancelBtn:IconButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _starBox:StarBar;
      
      public function FarmMountItem()
      {
         super();
         initView();
      }
      
      public function get data() : ShowMountMsgInfo
      {
         return _data;
      }
      
      public function set data(param1:ShowMountMsgInfo) : void
      {
         _data = param1;
         if(data == null)
         {
            if(_mount)
            {
               removeChild(_mount);
               _mount.dispose();
               _mount = null;
               _cancelBtn.visible = false;
               _nameTxt.visible = false;
               _starBox.visible = false;
            }
            return;
         }
         mountTempId = data.templateId;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("farm.MountBottom");
         _back.setFrame(1);
         addChild(_back);
         _filter = new UIFilter();
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("farm.CancelMountBtn");
         addChild(_cancelBtn);
         _cancelBtn.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.MountNameTxt");
         addChild(_nameTxt);
         _nameTxt.visible = false;
         _starBox = new StarBar(5,0,"asset.wildsoul.EmptyStar","asset.wildsoul.FullStar");
         _starBox.mouseEnabled = _starBox.mouseChildren = false;
         addChild(_starBox);
         _starBox.x = 5;
         _starBox.y = -54;
         _starBox.visible = false;
         addEvent();
      }
      
      private function initMount() : void
      {
         _mount = new MountsAvatarView();
         _mount.scaleX = _mount.scaleY = 0.5;
         _mount.x = 43;
         _mount.y = 50;
         addChildAt(_mount,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseDown",_clickHandler);
         addEventListener("mouseOver",_mouseOverHandler);
         addEventListener("mouseOut",_mouseOutHandler);
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",onCancelClick);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",_clickHandler);
         removeEventListener("mouseOver",_mouseOverHandler);
         removeEventListener("mouseOut",_mouseOutHandler);
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",onCancelClick);
         }
      }
      
      public function get mountTempId() : int
      {
         return _mountTempId;
      }
      
      public function set mountTempId(param1:int) : void
      {
         _mountTempId = param1;
         if(_mount == null)
         {
            initMount();
         }
         _mount.data = TempleteManager.instance.mountTemplateDic[_mountTempId];
      }
      
      private function _clickHandler(param1:MouseEvent) : void
      {
         if(!buttonMode)
         {
            return;
         }
         if(param1.target == _cancelBtn)
         {
            return;
         }
         selectPet(param1.stageX + 60,param1.stageY - 80);
         FarmManager.instance.model.currentMountPos = pos;
         param1.stopImmediatePropagation();
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         FarmManager.instance.model.currentMountPos = pos;
         FarmManager.instance.showMount(0);
      }
      
      private function selectPet(param1:int, param2:int) : void
      {
         _tipView = ComponentFactory.Instance.creatComponentByStylename("farm.FarmMountSelectMenu");
         _tipView.show();
         _tipView.x = param1;
         _tipView.y = param2;
      }
      
      private function _mouseOverHandler(param1:MouseEvent) : void
      {
         changeButtonMode();
         var _loc2_:Boolean = isSelfFarm();
         if(buttonMode)
         {
            _filter.setLightingFilter(this);
         }
         if(data == null)
         {
            return;
         }
         if(isSelfFarm())
         {
            _cancelBtn.visible = true;
         }
         _nameTxt.visible = true;
         _starBox.visible = true;
         if(data.isValid)
         {
            _starBox.visible = false;
         }
         var _loc3_:MountTemplate = TempleteManager.instance.mountTemplateDic[mountTempId];
         if(_loc3_ == null)
         {
            return;
         }
         _starBox.visible = true;
         if(_loc3_.MountType == 4)
         {
            _starBox.visible = false;
         }
         _nameTxt.text = _loc3_.TemplateName;
         _starBox.progress = data.starlevel;
         _starBox.count = _loc3_.maxStarGrade;
      }
      
      private function changeButtonMode() : void
      {
         var _loc1_:Boolean = isSelfFarm();
         buttonMode = false;
         if(_loc1_)
         {
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
      }
      
      private function _mouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(this);
         buttonMode = false;
         _cancelBtn.visible = false;
         _nameTxt.visible = false;
         _starBox.visible = false;
      }
      
      private function isSelfFarm() : Boolean
      {
         return FarmManager.instance.model.curSelectedFarmInfo == FarmManager.instance.model.myFarm;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_mount);
         _mount = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_data);
         _data = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

