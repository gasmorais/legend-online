package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dreamarena.item.DreamArenaTitanSkillItem;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class DreamArenaTitanView extends Component
   {
      
      private static const EQUIP_COUNT:int = 12;
      
      private static const SKILL_COUNT:int = 10;
      
      private static const ARROW_COUNT:int = 8;
      
      private var _sortImage:Image;
      
      private var _title:Image;
      
      private var _back:ScaleBitmapImage;
      
      private var _line:Image;
      
      private var _saveBtn:BaseButton;
      
      private var _sortContiner:TileContainer;
      
      private var sortList:Vector.<DreamArenaTitanSkillItem>;
      
      private var _arrowContiner:TileContainer;
      
      private var _equipContiner:TileContainer;
      
      private var equipList:Vector.<DreamArenaTitanSkillItem>;
      
      public function DreamArenaTitanView()
      {
         super();
         initView();
         initSkillView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _sortImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.sortImage");
         _title = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.back");
         _line = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTitanView.line");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTitanView.saveBtn");
         _sortContiner = ComponentFactory.Instance.creatCustomObject("DreamArenaTitanView.sortContiner");
         _arrowContiner = ComponentFactory.Instance.creatCustomObject("DreamArenaTitanView.arrowContiner");
         _equipContiner = ComponentFactory.Instance.creatCustomObject("DreamArenaTitanView.equipContiner");
         addChild(_sortImage);
         addChild(_back);
         addChild(_sortContiner);
         addChild(_arrowContiner);
         addChild(_line);
         addChild(_title);
         addChild(_equipContiner);
         addChild(_saveBtn);
         _arrowContiner.mouseChildren = _arrowContiner.mouseEnabled = false;
      }
      
      private function initSkillView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:DreamArenaTitanSkillItem = null;
         var _loc1_:Image = null;
         var _loc3_:DreamArenaTitanSkillItem = null;
         sortList = new Vector.<DreamArenaTitanSkillItem>();
         equipList = new Vector.<DreamArenaTitanSkillItem>();
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc2_ = new DreamArenaTitanSkillItem(1,_loc4_);
            _sortContiner.appendItem(_loc2_);
            sortList.push(_loc2_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("DreamArenaHeroView.skillArrow");
            _arrowContiner.appendItem(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc3_ = new DreamArenaTitanSkillItem(2,_loc4_);
            _equipContiner.appendItem(_loc3_);
            equipList.push(_loc3_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _saveBtn.addEventListener("click",__saveTitanHandler);
         MsgMan.addObserver("TITAN_SET_SKILL",this,__updateSortSkillHandler);
         MsgMan.addObserver("TITAN_CLIENT_SKILL_UPDATE",this,__updateEquipSkillHandler);
      }
      
      private function removeEvent() : void
      {
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveTitanHandler);
         }
         MsgMan.removeObserver("TITAN_SET_SKILL",this,__updateSortSkillHandler);
         MsgMan.removeObserver("TITAN_CLIENT_SKILL_UPDATE",this,__updateEquipSkillHandler);
      }
      
      private function __saveTitanHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = selectInfo.titanSkills;
         if(model.clientSelectDic[21])
         {
            _loc2_ = (model.clientSelectDic[21] as Array).join(",");
         }
         if(_loc2_.split(",").length < 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.titanCount.noEnough"));
            return;
         }
         DreamArenaManager.instance.sendTitanOrRuneSelect(6,_loc2_);
      }
      
      private function __updateEquipSkillHandler(param1:String = null, param2:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DreamArenaTitanSkillItem = null;
         var _loc3_:DreamArenaTitanSkillItem = null;
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc6_ = sortList[_loc5_];
            if(_loc6_.data)
            {
               _loc4_.push(_loc6_.data.TemplateId);
            }
            _loc5_++;
         }
         model.clientSelectDic.add(21,_loc4_);
         _loc5_ = 0;
         while(_loc5_ < equipList.length)
         {
            _loc3_ = equipList[_loc5_];
            _loc3_.refreshClientSelect();
            _loc5_++;
         }
         refreshSaveBtn();
      }
      
      private function __updateSortSkillHandler(param1:String = null, param2:Object = null) : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc5_:DreamArenaTitanSkillItem = param2.dragItem as DreamArenaTitanSkillItem;
         var _loc3_:DreamArenaTitanSkillItem = param2.dropItem as DreamArenaTitanSkillItem;
         if(!_loc5_ || !_loc3_)
         {
            return;
         }
         var _loc6_:int = _loc5_.index;
         var _loc7_:int = _loc3_.index;
         if(_loc3_.data)
         {
            _loc4_ = _loc5_.data;
            sortList[_loc6_].data = _loc3_.data;
            sortList[_loc7_].data = _loc4_;
         }
         else
         {
            sortList[_loc7_].data = _loc5_.data;
            sortList[_loc6_].data = null;
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:DreamArenaTitanSkillItem = null;
         var _loc2_:SkillTempInfo = null;
         var _loc3_:DragonTitanTempInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc4_ = sortList[_loc1_];
            _loc2_ = TempleteManager.instance.skillTemplateDic[selectInfo.titanSkillAry[_loc1_]];
            _loc4_.data = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc3_ = TempleteManager.instance.titanTemplateCate.getTitanList()[_loc1_];
            if(_loc3_)
            {
               _loc4_ = equipList[_loc1_];
               _loc2_ = TempleteManager.instance.skillTemplateDic[_loc3_.SkillIds];
               _loc4_.data = _loc2_;
            }
            _loc1_++;
         }
         refreshSaveBtn();
      }
      
      private function refreshSaveBtn() : void
      {
         _saveBtn.enable = model.getTitanChange();
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
         ObjectUtils.disposeObject(_sortImage);
         _sortImage = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_sortContiner);
         _sortContiner = null;
         ObjectUtils.disposeObject(_arrowContiner);
         _arrowContiner = null;
         ObjectUtils.disposeObject(_equipContiner);
         _equipContiner = null;
         LogicUtils.disposeDisplayCollection(sortList);
         sortList = null;
         LogicUtils.disposeDisplayCollection(equipList);
         equipList = null;
         model.clientSelectDic.del(21);
         super.dispose();
      }
   }
}

