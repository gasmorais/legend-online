package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.crossguild.CrossGuildTowerInfo;
   import yishi.datas.templates.CrossGuildWarQuestTempInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class CrossGuildAttackItem extends Component
   {
      
      private var _troubleText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _troubleBtn:IconButton;
      
      private var _fortifiedAttackBtn:IconButton;
      
      private var _attackBtn:IconButton;
      
      private var _attackIcon:ScaleFrameImage;
      
      private var _taskText:FilterFrameText;
      
      private var index:int;
      
      private var _data:CrossGuildTowerInfo;
      
      private var spiritCost:int;
      
      private var maxTroubleCount:int;
      
      public function CrossGuildAttackItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _attackIcon = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackItem.attackIcon");
         _troubleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackItem.troubleText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackItem.descText");
         _troubleBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackItem.troubleBtn");
         _fortifiedAttackBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackItem.fortifiedAttackBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackItem.attackBtn");
         _taskText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackItem.taskText");
         addChild(_attackIcon);
         _attackIcon.setFrame(index + 1);
         addChild(_descText);
         addChild(_attackBtn);
         _attackBtn.visible = index == 0;
         addChild(_fortifiedAttackBtn);
         _fortifiedAttackBtn.visible = index == 1;
         addChild(_troubleBtn);
         _troubleBtn.visible = index == 2;
         addChild(_troubleText);
         addChild(_taskText);
         spiritCost = model.attackConfigAry[index];
         maxTroubleCount = model.attackConfigAry[3];
         _descText.text = LanguageMgr.GetTranslation("CrossGuildAttackItem.descText.text" + index,spiritCost,maxTroubleCount);
      }
      
      private function addEvent() : void
      {
         _attackBtn.addEventListener("click",_attackBtnClickHandler);
         _fortifiedAttackBtn.addEventListener("click",_fortifiedAttackBtnClickHandler);
         _troubleBtn.addEventListener("click",_troubleBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",_attackBtnClickHandler);
         }
         if(_fortifiedAttackBtn)
         {
            _fortifiedAttackBtn.removeEventListener("click",_fortifiedAttackBtnClickHandler);
         }
         if(_troubleBtn)
         {
            _troubleBtn.removeEventListener("click",_troubleBtnClickHandler);
         }
      }
      
      private function _attackBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkSpirit())
         {
            return;
         }
         checkIsAlertFighting(1);
      }
      
      private function _fortifiedAttackBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkSpirit())
         {
            return;
         }
         checkIsAlertFighting(2);
      }
      
      private function _troubleBtnClickHandler(param1:MouseEvent) : void
      {
         if(!checkSpirit())
         {
            return;
         }
         if(_data.troubleCount >= 6 * maxTroubleCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("CrossGuildAttackItem.noTroubleCount.alert"));
            return;
         }
         CrossGuildManager.instance.sendCrossGuildTowerAttack(_data.teamId,_data.towerId,3);
      }
      
      private function checkSpirit() : Boolean
      {
         if(model.curSpirit < spiritCost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("CrossGuildAttackItem.noSpirit.alert"));
            return false;
         }
         if(_data.blood <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("CrossGuildAttackItem.noBlood.alert"));
            return false;
         }
         return true;
      }
      
      private function checkIsAlertFighting(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_data.attackCount > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("CrossGuildAttackItem.attack.fightingAlert");
            SimpleAlertHelper.instance.data = [confirmFightHandler,param1];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
         }
         else
         {
            CrossGuildManager.instance.sendCrossGuildTowerAttack(_data.teamId,_data.towerId,param1);
         }
      }
      
      private function confirmFightHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            CrossGuildManager.instance.sendCrossGuildTowerAttack(_data.teamId,_data.towerId,param3);
         }
      }
      
      public function refreshView(param1:CrossGuildTowerInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CrossGuildWarQuestTempInfo = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_data.troubleCount % maxTroubleCount == 0)
         {
            _loc3_ = Math.min(_data.troubleCount / maxTroubleCount + 1,6);
         }
         else
         {
            _loc3_ = Math.ceil(_data.troubleCount / maxTroubleCount);
         }
         _taskText.text = "";
         _troubleText.text = "";
         if(index == 2)
         {
            _troubleText.text = "(" + _data.troubleCount + "/" + _loc3_ * maxTroubleCount + ")";
            _loc2_ = TempleteManager.instance.crossGuildWarQuestTempCate.getTemplateById(_data.questId);
            if(_loc2_)
            {
               _taskText.text = LanguageMgr.GetTranslation("CrossGuildAttackItem.taskText.text",_loc2_.Description);
               _taskText.y = _descText.y + _descText.textHeight + 5;
            }
         }
         _attackBtn.enable = _fortifiedAttackBtn.enable = _troubleBtn.enable = model.myTeamId != _data.teamId;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_troubleText);
         _troubleText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_troubleBtn);
         _troubleBtn = null;
         ObjectUtils.disposeObject(_fortifiedAttackBtn);
         _fortifiedAttackBtn = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_attackIcon);
         _attackIcon = null;
         ObjectUtils.disposeObject(_taskText);
         _taskText = null;
         super.dispose();
      }
   }
}

