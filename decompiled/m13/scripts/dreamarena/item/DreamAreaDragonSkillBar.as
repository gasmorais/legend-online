package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class DreamAreaDragonSkillBar extends Component
   {
      
      private var _skillHbox:HBox;
      
      private var _type:int;
      
      public function DreamAreaDragonSkillBar(param1:int)
      {
         super();
         _type = param1;
         initView();
         initSkills();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArena.dragonSkillHbox");
         addChild(_skillHbox);
      }
      
      private function initSkills() : void
      {
         var _loc1_:DreamAreaDragonSelectSkillItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,_loc5_);
         var _loc2_:Array = [];
         if(_loc3_)
         {
            _loc2_ = _loc3_["Skill" + _type].split(";");
         }
         _skillHbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("DreamArena.dragonSkillItem",[_type]);
            _loc1_.skillIds = _loc2_[_loc4_];
            if(_type == 1)
            {
               _loc1_.titleText = LanguageMgr.GetTranslation("dreamarea.skill.inactive",_loc4_ + 1);
            }
            else
            {
               _loc1_.titleText = LanguageMgr.GetTranslation("dreamarea.skill.passtive",_loc4_ + 1);
            }
            _skillHbox.addChild(_loc1_);
            _loc4_++;
         }
         _skillHbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("DreamAreaDragonSkillChange",selectedChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("DreamAreaDragonSkillChange",selectedChangeHandler);
      }
      
      private function selectedChangeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = int(param1.data);
         if(_type != _loc3_)
         {
            return;
         }
         var _loc4_:String = selectIds;
         model.clientSelectDic.add(22,_loc4_);
         model.clientSelectDic.add(22 + 100 + _type,_loc4_);
         var _loc2_:int = 22;
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc2_);
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      public function refreshClientSelect() : void
      {
      }
      
      public function setJobType(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:DreamAreaDragonSelectSkillItem = null;
         var _loc4_:int = 0;
         var _loc6_:DreamArenaSelectRoleInfo = DreamArenaManager.instance.model.selfInfo;
         if(_type == 1)
         {
            _loc3_ = _loc6_.dragonSkill;
         }
         else if(_type == 2)
         {
            _loc3_ = _loc6_.dragonPassiveSkill;
         }
         var _loc5_:Array = _loc3_.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc2_ = _skillHbox.getChildAt(_loc4_) as DreamAreaDragonSelectSkillItem;
            _loc2_.selectIdx = int(_loc5_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function get selectIds() : String
      {
         var _loc2_:DreamAreaDragonSelectSkillItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_skillHbox.numChildren);
         var _loc1_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _skillHbox.getChildAt(_loc4_) as DreamAreaDragonSelectSkillItem;
            if(_loc4_ < _loc3_ - 1)
            {
               _loc1_ += _loc2_.selectIdx + ",";
            }
            else
            {
               _loc1_ += _loc2_.selectIdx;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         super.dispose();
      }
   }
}

