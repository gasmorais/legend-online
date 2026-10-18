package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaCommonSelectItemII extends Component
   {
      
      private var _itemBg:Image;
      
      private var _icon:BaseIconView;
      
      private var _selectBg:Image;
      
      private var _hasSelectBtn:IconButton;
      
      private var _selectBtn:IconButton;
      
      public var index:int;
      
      public var type:int;
      
      private var _data:DreamArenaTempInfo;
      
      public function DreamArenaCommonSelectItemII(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaCommonSelectItemII.itemBg");
         _icon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaChildPetSelectItem.icon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaCommonSelectItemII.selectBg");
         _hasSelectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaChildPetSelectItem.hasSelectBtn");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaChildPetSelectItem.selectBtn");
         addChild(_itemBg);
         addChild(_icon);
         addChild(_selectBg);
         addChild(_selectBtn);
         addChild(_hasSelectBtn);
         _selectBg.visible = false;
         _hasSelectBtn.enable = false;
         _hasSelectBtn.visible = false;
         _selectBg.mouseEnabled = false;
         if(type == 1)
         {
            _itemBg.visible = false;
            _icon.scaleX = _icon.scaleY = 1;
            _icon.x = 13;
            _icon.y = 13;
         }
         else
         {
            _itemBg.visible = true;
            _icon.scaleX = _icon.scaleY = 0.75;
            _icon.x = 23;
            _icon.y = 20;
         }
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",_selectBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",_selectBtnClickHandler);
         }
      }
      
      private function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         if(type == 1)
         {
            model.clientSelectDic.add(6,data.TemplateId);
            _loc2_ = 6;
         }
         else if(type == 2)
         {
            model.clientSelectDic.add(32,data.TemplateId);
            _loc2_ = 32;
         }
         else if(type == 3)
         {
            model.clientSelectDic.add(42,data.TemplateId);
            _loc2_ = 42;
         }
         else if(type == 4)
         {
            if(!model.clientSelectDic[9])
            {
               model.clientSelectDic.add(9,[]);
            }
            _loc3_ = model.clientSelectDic[9] as Array;
            if(_loc3_.length >= 2)
            {
               _loc3_ = [data.TemplateId];
            }
            else
            {
               _loc3_.push(data.TemplateId);
            }
            model.clientSelectDic.add(9,_loc3_);
            _loc2_ = 9;
         }
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
      
      public function get data() : DreamArenaTempInfo
      {
         return _data;
      }
      
      public function set data(param1:DreamArenaTempInfo) : void
      {
         var _loc4_:ArtifactTemplateInfo = null;
         var _loc3_:PetTemplate = null;
         var _loc5_:PetTemplate = null;
         var _loc2_:RuneTemplateInfo = null;
         _data = param1;
         if(data)
         {
            setTipData();
            if(type == 1)
            {
               _loc4_ = data.typeTempInfo as ArtifactTemplateInfo;
               if(_loc4_)
               {
                  _icon.icon = IconFactory.getCommonIconPath(_loc4_.Icon);
               }
               _selectBg.visible = data.TemplateId == selectInfo.artifactId;
               _hasSelectBtn.visible = data.TemplateId == selectInfo.artifactId;
               _selectBtn.visible = data.TemplateId != selectInfo.artifactId;
            }
            else if(type == 2)
            {
               _loc3_ = data.typeTempInfo as PetTemplate;
               if(_loc3_)
               {
                  _icon.icon = IconFactory.getPetHeadSmallIcon(_loc3_.TemplateId);
               }
               _selectBg.visible = data.TemplateId == selectInfo.mainChildPetId;
               _hasSelectBtn.visible = data.TemplateId == selectInfo.mainChildPetId;
               _selectBtn.visible = data.TemplateId != selectInfo.mainChildPetId;
            }
            else if(type == 3)
            {
               _loc5_ = data.typeTempInfo as PetTemplate;
               if(_loc5_)
               {
                  _icon.icon = IconFactory.getPetHeadSmallIcon(_loc5_.TemplateId);
               }
               _selectBg.visible = data.TemplateId == selectInfo.slaveChildPetId;
               _hasSelectBtn.visible = data.TemplateId == selectInfo.slaveChildPetId;
               _selectBtn.visible = data.TemplateId != selectInfo.slaveChildPetId;
            }
            else if(type == 4)
            {
               _loc2_ = data.typeTempInfo as RuneTemplateInfo;
               if(_loc2_)
               {
                  _icon.icon = IconFactory.getTecIconByIcon(_loc2_.Icon);
               }
               _selectBg.visible = selectInfo.runeArys.indexOf(data.TemplateId) != -1;
               _hasSelectBtn.visible = selectInfo.runeArys.indexOf(data.TemplateId) != -1;
               _selectBtn.visible = selectInfo.runeArys.indexOf(data.TemplateId) == -1;
            }
         }
         else
         {
            _icon.icon = null;
            _icon.tipData = null;
            _selectBg.visible = false;
            _hasSelectBtn.visible = false;
            _selectBtn.visible = false;
         }
      }
      
      private function setTipData() : void
      {
         var _loc1_:SkillTempInfo = null;
         var _loc2_:SkillPropertyTempInfo = null;
         if(type == 1)
         {
            _loc1_ = TempleteManager.instance.skillTemplateDic[data.Skill1];
            _loc2_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(data.PropertyId);
            _icon.tipStyle = "yishi.view.tips.goods.ArtifactEquipTip";
            _icon.tipData = {
               "type":"dreamArena",
               "tempInfo":data.typeTempInfo as ArtifactTemplateInfo,
               "skillTemp":_loc1_,
               "propTemp":_loc2_
            };
         }
         else if(type == 2 || type == 3)
         {
            _icon.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            _icon.tipData = data;
         }
         else if(type == 4)
         {
            _icon.tipStyle = "yishi.view.tips.goods.RuneTips";
            _icon.tipData = data.typeTempInfo as RuneTemplateInfo;
         }
      }
      
      public function refreshClientSelect() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Array = null;
         if(!data)
         {
            return;
         }
         if(type == 1)
         {
            _loc2_ = data.TemplateId == model.clientSelectDic[6];
            _selectBg.visible = _loc2_;
            _hasSelectBtn.visible = _loc2_;
            _selectBtn.visible = !_loc2_;
         }
         else if(type == 2)
         {
            _loc2_ = data.TemplateId == model.clientSelectDic[32];
            _selectBg.visible = _loc2_;
            _hasSelectBtn.visible = _loc2_;
            _selectBtn.visible = !_loc2_;
         }
         else if(type == 3)
         {
            _loc2_ = data.TemplateId == model.clientSelectDic[42];
            _selectBg.visible = _loc2_;
            _hasSelectBtn.visible = _loc2_;
            _selectBtn.visible = !_loc2_;
         }
         else if(type == 4)
         {
            if(!model.clientSelectDic[9])
            {
               _loc2_ = false;
            }
            else
            {
               _loc1_ = model.clientSelectDic[9] as Array;
               _loc2_ = _loc1_.indexOf(data.TemplateId) != -1;
            }
            _selectBg.visible = _loc2_;
            _hasSelectBtn.visible = _loc2_;
            _selectBtn.visible = !_loc2_;
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
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_hasSelectBtn);
         _hasSelectBtn = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         super.dispose();
      }
   }
}

