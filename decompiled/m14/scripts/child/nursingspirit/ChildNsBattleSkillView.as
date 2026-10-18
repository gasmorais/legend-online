package child.nursingspirit
{
   import child.skill.ChildBattleSkillItemView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class ChildNsBattleSkillView extends Component
   {
      
      private var battleImage:Bitmap;
      
      private var skillHbox:HBox;
      
      private var skillList:Vector.<ChildBattleSkillItemView>;
      
      public function ChildNsBattleSkillView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         battleImage = ComponentFactory.Instance.creatBitmap("asset.ChildNsBattleSkillView.battleImage");
         skillHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNsBattleSkillView.battleSkillHbox");
         addChild(battleImage);
         addChild(skillHbox);
      }
      
      private function initListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildBattleSkillItemView = null;
         skillList = new Vector.<ChildBattleSkillItemView>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildNsBattleSkillView.skillItem",[2]);
            _loc2_.index = _loc1_ + 1;
            skillHbox.addChild(_loc2_);
            skillList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("REFRESHCHILDBATTLESKILL",__refreshChildNsBattleSkillHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("REFRESHCHILDBATTLESKILL",__refreshChildNsBattleSkillHandler);
      }
      
      private function __refreshChildNsBattleSkillHandler(param1:NotificationEvent) : void
      {
         ChildSender.carrySkill(nsModel.selectedNsChild.childId,getCurrBattleSkillStr());
      }
      
      public function refreshView() : void
      {
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc8_:ChildBattleSkillItemView = null;
         var _loc2_:Array = null;
         var _loc3_:SkillTempInfo = null;
         var _loc7_:int = 0;
         var _loc5_:String = nsModel.selectedNsChild.fightSkill;
         if(_loc5_)
         {
            _loc1_ = _loc5_.split(",");
         }
         var _loc6_:Array = [];
         var _loc9_:String = nsModel.selectedNsChild.nursingSpiritInfo.trainInfo.skills;
         if(_loc9_ != null && _loc9_.length > 0)
         {
            _loc6_ = _loc9_.split(",");
         }
         _loc4_ = 0;
         while(_loc4_ < skillList.length)
         {
            _loc8_ = skillList[_loc4_];
            _loc8_.updateFmBuff(int(_loc6_[_loc4_]));
            if(_loc1_ && _loc1_[_loc4_] && _loc1_[_loc4_] != "-1")
            {
               _loc2_ = nsModel.selectedNsChild.skill.split(",");
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  if(_loc2_[_loc7_] && parseInt(_loc2_[_loc7_]) > 0)
                  {
                     if(TempleteManager.instance.getSkillById(_loc2_[_loc7_]).SonType == _loc1_[_loc4_])
                     {
                        _loc3_ = TempleteManager.instance.getSkillById(_loc2_[_loc7_]);
                     }
                  }
                  _loc7_++;
               }
               _loc8_.data = _loc3_;
            }
            else
            {
               _loc8_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function getCurrBattleSkillStr() : String
      {
         var _loc3_:int = 0;
         var _loc2_:ChildBattleSkillItemView = null;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = skillList[_loc3_];
            if(_loc2_.data)
            {
               if(_loc3_ == 4)
               {
                  _loc1_ += _loc2_.data.SonType;
               }
               else
               {
                  _loc1_ += _loc2_.data.SonType + ",";
               }
            }
            else if(_loc3_ == 4)
            {
               _loc1_ += "-1";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(battleImage);
         battleImage = null;
         ObjectUtils.disposeObject(skillHbox);
         skillHbox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

