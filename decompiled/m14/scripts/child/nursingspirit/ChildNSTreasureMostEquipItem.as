package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildNSTreasureMostEquipItem extends Component
   {
      
      private var _bg:Image;
      
      private var _activeFrameImg:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _equipBtn:IconButton;
      
      private var _typeBtn:BaseButton;
      
      private var _filter:UIFilter;
      
      private var _data:SkillTempInfo;
      
      private var _type:int;
      
      private var _isActive:Boolean;
      
      private var _index:int;
      
      private var _quardList:Array;
      
      public function ChildNSTreasureMostEquipItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostEquipItem.bg");
         _activeFrameImg = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostEquipItem.activeFrameImg");
         _icon = ComponentFactory.Instance.creatCustomObject("child.childBattleSkillItemView.icon");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostEquipItem.equipBtn");
         _typeBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostEquipItem.typeBtn");
         addChild(_bg);
         addChild(_icon);
         _icon.x = _icon.y = 10;
         addChild(_equipBtn);
         addChild(_typeBtn);
         addChild(_activeFrameImg);
         _typeBtn.visible = false;
         _filter = new UIFilter();
         _quardList = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_activeFrameImg);
         _activeFrameImg = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_typeBtn);
         _typeBtn = null;
      }
      
      private function initEvent() : void
      {
         _equipBtn.addEventListener("click",__changeTypeHandler);
         _typeBtn.addEventListener("click",__changeTypeHandler);
      }
      
      private function removeEvent() : void
      {
         _equipBtn.removeEventListener("click",__changeTypeHandler);
         _typeBtn.removeEventListener("click",__changeTypeHandler);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
         if(_isActive)
         {
            _activeFrameImg.setFrame(2);
            _filter.setNormalFilter(_icon);
            _equipBtn.enable = true;
            _equipBtn.tipData = LanguageMgr.GetTranslation("child.nursingspirit.childNSTreasureMostEquipItem.canRefresh");
         }
         else
         {
            _activeFrameImg.setFrame(1);
            _filter.setGrayFilter(_icon);
            _equipBtn.enable = false;
            _equipBtn.tipData = LanguageMgr.GetTranslation("child.nursingspirit.childNSTreasureMostEquipItem.refresh",20 * (_index + 1));
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         if(_type >= 0)
         {
            _typeBtn.visible = true;
            _equipBtn.mouseEnabled = false;
            _typeBtn.backStyle = "childTreasureMostEquipItem.typeFrameImg" + (_type + 1);
            _typeBtn.tipData = _quardList[_type];
         }
         else
         {
            _typeBtn.visible = false;
            _equipBtn.mouseEnabled = true;
         }
      }
      
      private function __changeTypeHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = _index;
         var _loc4_:int = _type;
         _loc2_.frameIndex = _loc3_;
         _loc2_.frameResiType = _loc4_;
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","ENCHANT",_loc2_);
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_icon)
         {
            _icon.icon = null;
            _icon.tipData = null;
            if(!_data)
            {
               return;
            }
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _icon.tipData = _data;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

