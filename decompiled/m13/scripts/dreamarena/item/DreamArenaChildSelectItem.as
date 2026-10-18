package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.view.DreamArenaChildSkillView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaChildSelectItem extends Component
   {
      
      private var _itemBg:Image;
      
      private var _childIcon:BaseIconView;
      
      private var _selectBg:Image;
      
      private var _lookBtn:BaseButton;
      
      private var _selectBtn:BaseButton;
      
      private var _hasSelectBtn:BaseButton;
      
      private var showSkillView:DreamArenaChildSkillView;
      
      public var type:int;
      
      public var index:int;
      
      private var _data:DreamArenaTempInfo;
      
      public function DreamArenaChildSelectItem(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildSelectItem.itemBg");
         _childIcon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaChildSelectItem.childIcon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.selectBg");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.selectBtn");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaChildSelectItem.lookBtn");
         _hasSelectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildSelectItem.hasSelectBtn");
         addChild(_itemBg);
         addChild(_childIcon);
         addChild(_selectBg);
         addChild(_lookBtn);
         addChild(_selectBtn);
         addChild(_hasSelectBtn);
         _hasSelectBtn.enable = false;
         _selectBg.visible = false;
         _selectBg.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _lookBtn.addEventListener("click",_lookBtnClickHandler);
         _selectBtn.addEventListener("click",_selectBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",_lookBtnClickHandler);
         }
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",_selectBtnClickHandler);
         }
      }
      
      private function _lookBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(!data)
         {
            return;
         }
         var _loc3_:Array = data.Skill1.split(",").concat(data.PassiveSkill1.split(","));
         if(!showSkillView)
         {
            showSkillView = new DreamArenaChildSkillView();
            showSkillView.show(_loc3_);
            showSkillView.addEventListener("dispose",__disposeShowView);
            _loc2_ = new Point(_lookBtn.displayWidth / 2,0);
            _loc2_ = _lookBtn.localToGlobal(_loc2_);
            showSkillView.x = _loc2_.x + 15;
            showSkillView.y = _loc2_.y + 5;
         }
      }
      
      private function __disposeShowView(param1:Event) : void
      {
         if(showSkillView)
         {
            showSkillView.removeEventListener("dispose",__disposeShowView);
         }
         showSkillView = null;
      }
      
      private function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(type == 1)
         {
            model.clientSelectDic.add(3,data.TemplateId);
            _loc2_ = 3;
         }
         else if(type == 2)
         {
            model.clientSelectDic.add(4,data.TemplateId);
            _loc2_ = 4;
         }
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
      
      public function get data() : DreamArenaTempInfo
      {
         return _data;
      }
      
      public function set data(param1:DreamArenaTempInfo) : void
      {
         var _loc2_:ChildTempInfo = null;
         _data = param1;
         if(data)
         {
            _loc2_ = data.typeTempInfo as ChildTempInfo;
            if(_loc2_)
            {
               _childIcon.icon = IconFactory.getHeroIconByPics(_loc2_.Icon);
               _childIcon.tipData = data;
               if(type == 1)
               {
                  _selectBtn.visible = data.TemplateId != selectInfo.mainChildId;
                  _hasSelectBtn.visible = data.TemplateId == selectInfo.mainChildId;
                  _selectBg.visible = data.TemplateId == selectInfo.mainChildId;
               }
               else
               {
                  _selectBtn.visible = data.TemplateId != selectInfo.slaveChildId;
                  _hasSelectBtn.visible = data.TemplateId == selectInfo.slaveChildId;
                  _selectBg.visible = data.TemplateId == selectInfo.slaveChildId;
               }
            }
         }
      }
      
      public function refreshClientSelect() : void
      {
         var _loc1_:Boolean = false;
         if(!data)
         {
            return;
         }
         if(type == 1)
         {
            _loc1_ = data.TemplateId == model.clientSelectDic[3];
            _hasSelectBtn.visible = _loc1_;
            _selectBg.visible = _loc1_;
            _selectBtn.visible = !_loc1_;
         }
         else if(type == 2)
         {
            _loc1_ = data.TemplateId == model.clientSelectDic[4];
            _hasSelectBtn.visible = _loc1_;
            _selectBg.visible = _loc1_;
            _selectBtn.visible = !_loc1_;
         }
      }
      
      private function get selectInfo() : DreamArenaSelectRoleInfo
      {
         return model.selfInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_childIcon);
         _childIcon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
         ObjectUtils.disposeObject(_hasSelectBtn);
         _hasSelectBtn = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(showSkillView);
         showSkillView = null;
         super.dispose();
      }
   }
}

