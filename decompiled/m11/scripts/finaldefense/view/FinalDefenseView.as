package finaldefense.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import managers.FinalDefenseManager;
   import mvc.module.finaldefense.FinalDefenseModel;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FinalDefenseView extends Sprite
   {
      
      public var _roleViewList:Dictionary;
      
      private var _finalDefenseShowSkill:FinalDefenseShowSkill;
      
      public var _dinalDefenseShowUseSkill:FinalDefenseShowUseSkill;
      
      public function FinalDefenseView()
      {
         super();
         _roleViewList = new Dictionary();
         _finalDefenseShowSkill = new FinalDefenseShowSkill(this);
         _dinalDefenseShowUseSkill = new FinalDefenseShowUseSkill(this);
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         this.graphics.beginFill(16777215,0);
         this.graphics.drawRect(0,0,1140,440);
         this.graphics.endFill();
      }
      
      private function onUpdateNPCRole(param1:Event) : void
      {
         var _loc3_:FinalDefenseMonsterView = null;
         for each(var _loc2_:DitchNpcInfoData in model.npcList)
         {
            _loc3_ = _roleViewList[_loc2_.id];
            if(_loc3_ == null)
            {
               _loc3_ = new FinalDefenseMonsterView(this);
               _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
               _roleViewList[_loc2_.id] = _loc3_;
               addChild(_loc3_);
            }
            _loc3_.data = _loc2_;
         }
         _finalDefenseShowSkill.roleList = _roleViewList;
         _dinalDefenseShowUseSkill.roleList = _roleViewList;
      }
      
      private function onUpdateSelfRole(param1:Event) : void
      {
         var _loc3_:FinalDefenseRoleView = null;
         for each(var _loc2_:DitchNpcInfoData in model.info.selfNPCList)
         {
            _loc3_ = _roleViewList[_loc2_.id];
            if(_loc3_ == null)
            {
               _loc3_ = new FinalDefenseRoleView(this);
               _roleViewList[_loc2_.id] = _loc3_;
               addChild(_loc3_);
            }
            _loc3_.data = _loc2_;
         }
      }
      
      override public function get width() : Number
      {
         return 1140;
      }
      
      override public function get height() : Number
      {
         return 440;
      }
      
      private function onGameStar(param1:Event) : void
      {
         for each(var _loc2_:FinalDefenseRoleView in _roleViewList)
         {
            _loc2_.gameStar();
         }
      }
      
      private function get model() : FinalDefenseModel
      {
         return FinalDefenseManager.ins.model;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ADD_NPC",onUpdateNPCRole);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onUpdateSelfRole);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_GAME_STAR",onGameStar);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ROLE_DEA",onRoleDea);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ADD_NPC",onUpdateNPCRole);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onUpdateSelfRole);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_GAME_STAR",onGameStar);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ROLE_DEA",onRoleDea);
      }
      
      private function onRoleDea(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         ObjectUtils.disposeObject(_roleViewList[_loc2_]);
         _roleViewList[_loc2_] = null;
         delete _roleViewList[_loc2_];
      }
      
      private function onRoundOver(param1:NotificationEvent) : void
      {
         for(var _loc2_:String in _roleViewList)
         {
            ObjectUtils.disposeObject(_roleViewList[_loc2_]);
            delete _roleViewList[_loc2_];
         }
         FinalDefenseManager.ins.model.cleanMonsterData();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_roleViewList != null)
         {
            for each(var _loc1_:FinalDefenseRoleView in _roleViewList)
            {
               ObjectUtils.disposeObject(_loc1_);
            }
            _roleViewList = null;
         }
         ObjectUtils.disposeObject(_finalDefenseShowSkill);
         _finalDefenseShowSkill = null;
         ObjectUtils.disposeObject(_dinalDefenseShowUseSkill);
         _dinalDefenseShowUseSkill = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

