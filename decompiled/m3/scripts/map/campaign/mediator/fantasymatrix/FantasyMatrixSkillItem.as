package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.FantasyMatrixModel;
   import mvc.module.room.RoomInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class FantasyMatrixSkillItem extends Component
   {
      
      private var skillIcon:BaseIconView;
      
      private var hasCountText:FilterFrameText;
      
      private var useBtn:IconButton;
      
      private var _skillId:int;
      
      public function FantasyMatrixSkillItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function initView() : void
      {
         skillIcon = ComponentFactory.Instance.creatCustomObject("FantasyMatrixSkillItem.skillIcon");
         hasCountText = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixSkillItem.hasCountText");
         useBtn = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixSkillItem.useBtn");
         addChild(skillIcon);
         addChild(hasCountText);
         addChild(useBtn);
      }
      
      private function addEvent() : void
      {
         useBtn.addEventListener("click",__useSkillCountHandler);
      }
      
      private function removeEvent() : void
      {
         if(useBtn)
         {
            useBtn.removeEventListener("click",__useSkillCountHandler);
         }
      }
      
      private function __useSkillCountHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         SoundManager.instance.play("022");
         if(roomInfo && roomInfo.houseOwnerId != ArmyManager.instance.thane.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("FantasyMatrixSkillItem.useSkill.noHouseOwner.alert"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.useSkill.skillName" + _skillId);
         if(_skillId == 1)
         {
            _loc6_ = model.skillAttackUpCount >= 1;
         }
         else if(_skillId == 2)
         {
            _loc6_ = model.skillScoreUpCount >= 1;
         }
         else if(_skillId == 3)
         {
            _loc6_ = model.skillAddScoreCount >= 1;
         }
         if(!_loc6_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("FantasyMatrixSkillItem.useSkill.noCountAlert"));
            return;
         }
         SimpleAlertHelper.instance.data = [buySkillHandlerBack];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:String = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.useBtn.content",_loc2_);
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc3_,_loc4_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function buySkillHandlerBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendFantasyMatrixUseSkill(_skillId);
         }
      }
      
      public function set skillId(param1:int) : void
      {
         _skillId = param1;
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.FantasyMatrixSkillItem.skillImage" + _skillId);
         var _loc2_:String = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.useSkill.skillName" + _skillId);
         skillIcon.icon = _loc3_;
         if(_skillId == 1)
         {
            hasCountText.text = model.skillAttackUpCount + "";
            skillIcon.tipData = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.skillAttackUpCount.tipData",_loc2_);
         }
         else if(_skillId == 2)
         {
            hasCountText.text = model.skillScoreUpCount + "";
            skillIcon.tipData = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.skillScoreUpCount.tipData",_loc2_);
         }
         else if(_skillId == 3)
         {
            hasCountText.text = model.skillAddScoreCount + "";
            skillIcon.tipData = LanguageMgr.GetTranslation("FantasyMatrixSkillItem.skillAddScoreCount.tipData",_loc2_);
         }
      }
      
      public function refreshView() : void
      {
         if(_skillId == 1)
         {
            hasCountText.text = model.skillAttackUpCount + "";
         }
         else if(_skillId == 2)
         {
            hasCountText.text = model.skillScoreUpCount + "";
         }
         else if(_skillId == 3)
         {
            hasCountText.text = model.skillAddScoreCount + "";
         }
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function get model() : FantasyMatrixModel
      {
         return CampaignManager.instance.fantasyMatrixModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(skillIcon);
         skillIcon = null;
         ObjectUtils.disposeObject(hasCountText);
         hasCountText = null;
         ObjectUtils.disposeObject(useBtn);
         useBtn = null;
         super.dispose();
      }
   }
}

