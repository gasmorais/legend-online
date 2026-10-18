package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaCommonSelectItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _selectBg:Image;
      
      private var _selectBtn:TextButton;
      
      public var index:int;
      
      public var type:int;
      
      private var _data:Object;
      
      private var armoryInfo:AncientArmoryInfo;
      
      public function DreamArenaCommonSelectItem(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaCommonSelectItem.icon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBg");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBtn");
         addChild(_icon);
         addChild(_selectBg);
         addChild(_selectBtn);
         _selectBg.mouseEnabled = false;
         armoryInfo = new AncientArmoryInfo();
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
            if(!model.clientSelectDic[7])
            {
               model.clientSelectDic.add(7,[]);
            }
            _loc3_ = model.clientSelectDic[7] as Array;
            if(_loc3_.length >= 3)
            {
               _loc3_ = [data.TemplateId];
            }
            else
            {
               _loc3_.push(data.TemplateId);
            }
            model.clientSelectDic.add(7,_loc3_);
            _loc2_ = 7;
         }
         else if(type == 2)
         {
            model.clientSelectDic.add(23,index);
            _loc2_ = 23;
         }
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:ArmoryTemplateInfo = null;
         _data = param1;
         if(data)
         {
            setTipData();
            if(type == 1)
            {
               _loc2_ = (data as DreamArenaTempInfo).typeTempInfo as ArmoryTemplateInfo;
               _icon.icon = IconFactory.getArmoryIconPath(_loc2_.TemplateId,5);
               _loc3_ = selectInfo.armoryAry.indexOf((data as DreamArenaTempInfo).TemplateId) != -1;
               _selectBtn.text = _loc3_ ? LanguageMgr.GetTranslation("dreamArena.selectBtn.hasSelectText") : LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
               _selectBg.visible = _loc3_;
               _selectBtn.enable = !_loc3_;
            }
            else if(type == 2)
            {
               _icon.icon = IconFactory.getTecIconByIcon((data as SkillTempInfo).Icons);
               _loc3_ = selectInfo.selfSelectJob == 4 && selectInfo.skillIndex2 == index;
               _selectBtn.text = _loc3_ ? LanguageMgr.GetTranslation("dreamArena.selectBtn.hasSelectText") : LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
               _selectBg.visible = _loc3_;
               _selectBtn.enable = !_loc3_;
            }
         }
         else
         {
            _icon.icon = null;
            _icon.tipData = null;
            _selectBg.visible = false;
         }
      }
      
      private function setTipData() : void
      {
         if(type == 1)
         {
            _icon.tipStyle = "yishi.view.tips.AncientArmoryTips";
            _icon.tipData = createArmoryInfo(data as DreamArenaTempInfo);
         }
         else if(type == 2)
         {
            _icon.tipStyle = "yishi.view.tips.goods.SkillTips";
            _icon.tipData = data as SkillTempInfo;
         }
      }
      
      private function createArmoryInfo(param1:DreamArenaTempInfo) : AncientArmoryInfo
      {
         var _loc2_:ArmoryTemplateInfo = (param1 as DreamArenaTempInfo).typeTempInfo as ArmoryTemplateInfo;
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1.PropertyId);
         armoryInfo.templateId = _loc2_.TemplateId;
         armoryInfo.grades = 5;
         armoryInfo.profile = 5;
         armoryInfo.attacks = _loc3_.Attack;
         armoryInfo.defences = _loc3_.Defence;
         armoryInfo.magicDefences = _loc3_.MagicDefence;
         armoryInfo.live = _loc3_.Live;
         armoryInfo.parry = _loc3_.Parry;
         armoryInfo.penetrate = _loc3_.Penetrate;
         return armoryInfo;
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
            if(!model.clientSelectDic[7])
            {
               _loc2_ = false;
            }
            else
            {
               _loc1_ = model.clientSelectDic[7] as Array;
               _loc2_ = _loc1_.indexOf((data as DreamArenaTempInfo).TemplateId) != -1;
            }
            _selectBtn.text = _loc2_ ? LanguageMgr.GetTranslation("dreamArena.selectBtn.hasSelectText") : LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
            _selectBg.visible = _loc2_;
            _selectBtn.enable = !_loc2_;
         }
         else if(type == 2)
         {
            if(!model.clientSelectDic[23])
            {
               _loc2_ = false;
            }
            else
            {
               _loc2_ = model.clientSelectDic[23] == index;
            }
            _selectBtn.text = _loc2_ ? LanguageMgr.GetTranslation("dreamArena.selectBtn.hasSelectText") : LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
            _selectBg.visible = _loc2_;
            _selectBtn.enable = !_loc2_;
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
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         super.dispose();
      }
   }
}

