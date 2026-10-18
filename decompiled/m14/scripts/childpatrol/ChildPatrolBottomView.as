package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ChildPatrolEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   import yzhkof.debug.log;
   
   public class ChildPatrolBottomView extends Component
   {
      
      private var back:MutipleImage;
      
      private var headBackHbox:HBox;
      
      private var headHbox:HBox;
      
      private var patrolBtn:IconButton;
      
      private var cancelBtn:IconButton;
      
      private var getRewardBtn:IconButton;
      
      private var exploreBtn:IconButton;
      
      private var cancelExploreBtn:IconButton;
      
      private var exploreTimeTilte:FilterFrameText;
      
      private var alertText:FilterFrameText;
      
      private var levelUpText:FilterFrameText;
      
      private var leftTimeText:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var restTimeText:FilterFrameText;
      
      private var taskTip:FilterFrameText;
      
      private var headList:Vector.<BaseIconView>;
      
      private var _data:ChildPatrolTowerInfo;
      
      private var _type:int;
      
      private var posArr:Array = [30,95,160,226];
      
      private var levelUpConfigInfo:ConfigInfosTempInfo;
      
      public function ChildPatrolBottomView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.back");
         headBackHbox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.headBackHbox");
         headHbox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.headHbox");
         patrolBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.patrolBtn");
         cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.cancelBtn");
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.getRewardBtn");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.alertText");
         levelUpText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.levelUpText");
         leftTimeText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.leftTimeText");
         restTimeText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.restTimeText");
         _time = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.UpdateTime");
         exploreBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.exploreBtn");
         cancelExploreBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.cancelExploreBtn");
         exploreTimeTilte = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolExplore.timeTitle");
         taskTip = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.taskTipText");
         addChild(back);
         addChild(headBackHbox);
         addChild(headHbox);
         addChild(patrolBtn);
         patrolBtn.visible = false;
         addChild(cancelBtn);
         cancelBtn.visible = false;
         addChild(getRewardBtn);
         getRewardBtn.visible = false;
         addChild(exploreBtn);
         exploreBtn.visible = false;
         addChild(cancelExploreBtn);
         cancelExploreBtn.visible = false;
         addChild(alertText);
         addChild(levelUpText);
         addChild(leftTimeText);
         addChild(restTimeText);
         addChild(_time);
         addChild(exploreTimeTilte);
         addChild(taskTip);
         headList = new Vector.<BaseIconView>();
         levelUpConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("child_patrol_garrison_time");
         leftTimeText.text = LanguageMgr.GetTranslation("ChildPatrolBottomView.leftTimeText.text");
         alertText.text = LanguageMgr.GetTranslation("ChildPatrolBottomView.alertText.text");
         exploreTimeTilte.text = LanguageMgr.GetTranslation("ChildPatrolExplore.exploreTimeTitle");
         taskTip.text = LanguageMgr.GetTranslation("ChildPatrolTowerAffectView.TaskTip");
      }
      
      private function addEvent() : void
      {
         patrolBtn.addEventListener("click",__patrolBtnClickHandler);
         cancelBtn.addEventListener("click",__cancelBtnClickHandler);
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
         exploreBtn.addEventListener("click",exploreClickHandler);
         cancelExploreBtn.addEventListener("click",cancelExploreHandler);
         ChildPatrolManager.instance.addEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
      }
      
      private function removeEvent() : void
      {
         patrolBtn.removeEventListener("click",__patrolBtnClickHandler);
         cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
         getRewardBtn.removeEventListener("click",__getRewardClickHandler);
         exploreBtn.removeEventListener("click",exploreClickHandler);
         cancelExploreBtn.removeEventListener("click",cancelExploreHandler);
         ChildPatrolManager.instance.removeEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
      }
      
      private function exploreClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_type == ChildFunType.EXPLORE)
         {
            if(!model.childIdList || model.childIdList.length <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.explore.noChilds.alert"));
               return;
            }
            ChildPatrolManager.instance.sendChildPatrolOperate(10,0,0,_data.towerId,model.childIdList);
         }
      }
      
      private function cancelExploreHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ChildPatrolManager.instance.sendChildPatrolOperate(11,0,0,_data.towerId);
      }
      
      private function __patrolBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChildPatrolTowerInfo = null;
         SoundManager.instance.play("022");
         if(_type == ChildFunType.QATROL || _type == ChildFunType.UP_LEVEL)
         {
            if(_type == ChildFunType.UP_LEVEL)
            {
               _loc2_ = ChildPatrolManager.instance.model.getChildPatrolTowerInfoByTowerId(100);
               if(_data.level == 9 && _loc2_ && _loc2_.level >= 10)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.tower.9to10"));
                  return;
               }
            }
            if(isFullLevelByType())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.tower.maxLevel.alert" + _type));
               return;
            }
            if(!model.childIdList || model.childIdList.length <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.tower.noChilds.alert"));
               return;
            }
            ChildPatrolManager.instance.sendChildPatrolOperate(3,0,0,_data.towerId,model.childIdList);
         }
         else if(_type == ChildFunType.TASK)
         {
            if(!model.checkIsReached(1,_data,model.childList))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.tower.Childs.noReached"));
               return;
            }
            ChildPatrolManager.instance.sendChildPatrolOperate(5,0,0,_data.towerId,model.childIdList);
         }
      }
      
      private function isFullLevelByType() : Boolean
      {
         var _loc1_:UpgradeTemplateInfo = null;
         if(_data.towerId == 100)
         {
            _loc1_ = model.findUpgradeTempInfoByTypeAndGrade(114,_data.level + 1);
         }
         else
         {
            _loc1_ = model.findUpgradeTempInfoByTypeAndGrade(115,_data.level + 1);
         }
         if(!_loc1_)
         {
            return true;
         }
         return false;
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc4_:int = _data.garrisonExpPerMinute * (int((playerModel.sysSecond - _data.garrisonStartTime) / 60));
         SimpleAlertHelper.instance.data = [cancelChildPatrolHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("ChildPatrolBottomView.cancel.content",_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function cancelChildPatrolHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(4,0,0,_data.towerId);
         }
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         if(_data.state == 3)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(7,0,0,_data.towerId);
         }
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         _data = param1;
         refreshChildList();
         refreshView();
      }
      
      private function refreshChildList() : void
      {
         var _loc2_:ChildData = null;
         model.childList = [];
         model.childIdList = [];
         var _loc1_:int = 0;
         if(_type == ChildFunType.QATROL || _type == ChildFunType.UP_LEVEL)
         {
            _loc1_;
            while(_loc1_ < _data.garrisonChildIdList.length)
            {
               model.childIdList.push(_data.garrisonChildIdList[_loc1_]);
               _loc2_ = ChildManager.instance.model.getChildById(_data.garrisonChildIdList[_loc1_]);
               model.childList.push(_loc2_);
               _loc1_++;
            }
         }
         else if(_type == ChildFunType.TASK)
         {
            _loc1_;
            while(_loc1_ < _data.patrolChildIdList.length)
            {
               model.childIdList.push(_data.patrolChildIdList[_loc1_]);
               _loc2_ = ChildManager.instance.model.getChildById(_data.patrolChildIdList[_loc1_]);
               model.childList.push(_loc2_);
               _loc1_++;
            }
         }
         else if(_type == ChildFunType.EXPLORE)
         {
            if(_data.exploreChildId > 0)
            {
               model.childIdList.push(_data.exploreChildId);
               _loc2_ = ChildManager.instance.model.getChildById(_data.exploreChildId);
               model.childList.push(_loc2_);
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:ChildData = null;
         cleanData();
         var _loc1_:int = int(model.childList.length);
         var _loc2_:int = 0;
         if(levelUpConfigInfo)
         {
            _loc3_ = parseInt(levelUpConfigInfo.ConfigValue);
         }
         if(_type == ChildFunType.QATROL || _type == ChildFunType.UP_LEVEL)
         {
            back.visible = true;
            leftTimeText.visible = true;
            restTimeText.visible = true;
            alertText.visible = true;
            _loc2_;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = model.childList[_loc2_];
               _loc4_ += int(Math.ceil(_loc5_.growthGrade / 3.5)) * _loc5_.growthGrade;
               _loc2_++;
            }
            if(_data.onGarrison)
            {
               _loc6_ = _loc3_ * _data.garrisonExpPerMinute;
               _time.timeCount = _data.garrisonLeftTime;
               _time.visible = true;
               cancelBtn.visible = true;
            }
            else
            {
               _loc6_ = _loc3_ * _loc4_;
               restTimeText.text = DateFormatter.getConsortiaCountDate(_loc3_ * 60);
               patrolBtn.visible = true;
            }
            levelUpText.htmlText = LanguageMgr.GetTranslation("ChildPatrolBottomView.levelUpText.Text",_loc6_);
         }
         else if(_type == ChildFunType.TASK)
         {
            back.visible = true;
            leftTimeText.visible = true;
            restTimeText.visible = true;
            taskTip.visible = true;
            if(_data.state == 1 || _data.state == 2)
            {
               _time.timeCount = _data.patrolLeftTime;
               _time.visible = true;
               getRewardBtn.visible = true;
               getRewardBtn.enable = false;
            }
            else if(_data.state == 3)
            {
               getRewardBtn.visible = true;
               getRewardBtn.enable = true;
               restTimeText.text = DateFormatter.getConsortiaCountDate(0);
            }
            else
            {
               patrolBtn.visible = true;
               _loc3_ = Number(model.getTaskNeedTimeByChildList(_data,model.childList));
               restTimeText.text = DateFormatter.getConsortiaCountDate(_loc3_);
            }
         }
         else if(_type == ChildFunType.EXPLORE)
         {
            back.visible = false;
            leftTimeText.visible = false;
            restTimeText.visible = false;
            if(_data.exploreLeftTime > 0)
            {
               if(_data.exploreChildId > 0)
               {
                  exploreTimeTilte.visible = true;
                  exploreBtn.visible = false;
                  cancelExploreBtn.visible = true;
                  cancelExploreBtn.enable = false;
                  _time.timeCount = _data.exploreLeftTime;
                  _time.visible = true;
                  _time.x = 176;
                  _time.y = -146;
               }
               else
               {
                  exploreBtn.visible = true;
                  cancelExploreBtn.visible = false;
                  log({},"探险服务器数据异{invalid_utf8=229}{invalid_utf8=184}?!探险守卫id=0,时间CD不为0");
               }
            }
            else if(_data.exploreChildId > 0)
            {
               exploreBtn.visible = false;
               cancelExploreBtn.visible = true;
               cancelExploreBtn.enable = true;
            }
            else
            {
               exploreBtn.visible = true;
               cancelExploreBtn.visible = false;
            }
         }
         createHeadIcon();
         createHeadBack();
      }
      
      private function createHeadBack() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc3_:int = int(model.getCanPatrolChildCount(_type,_data.level));
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolBottomView.childBack1");
            headBackHbox.addChild(_loc1_);
            _loc2_++;
         }
         headBackHbox.refreshChildPos();
         if(_type == ChildFunType.EXPLORE)
         {
            headBackHbox.x = 40;
            headBackHbox.y = -262;
            headHbox.x = 59;
            headHbox.y = -253;
         }
         else
         {
            headBackHbox.x = posArr[4 - _loc3_];
            headBackHbox.y = 35;
            headHbox.x = posArr[4 - _loc3_] + 19;
            headHbox.y = 44;
         }
      }
      
      private function createHeadIcon() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ChildData = null;
         var _loc1_:BaseIconView = null;
         var _loc4_:ChildTempInfo = null;
         _loc2_ = 0;
         while(_loc2_ < model.childList.length)
         {
            _loc3_ = model.childList[_loc2_];
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolBottomView.headIcon");
            _loc1_.addEventListener("click",__removeChildFromListHandler);
            headHbox.addChild(_loc1_);
            headList.push(_loc1_);
            _loc4_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
            if(_loc4_)
            {
               _loc1_.icon = PathManager.info.ResourcePath + "icon" + _loc4_.Icon;
               _loc1_.buttonMode = true;
            }
            _loc2_++;
         }
         headHbox.refreshChildPos();
      }
      
      private function cleanData() : void
      {
         levelUpText.text = "";
         restTimeText.text = "";
         alertText.visible = false;
         _time.timeCount = 0;
         _time.visible = false;
         _time.x = 370;
         _time.y = 150;
         patrolBtn.visible = false;
         cancelBtn.visible = false;
         getRewardBtn.visible = false;
         exploreBtn.visible = false;
         cancelExploreBtn.visible = false;
         exploreTimeTilte.visible = false;
         taskTip.visible = false;
         headBackHbox.removeAllChild();
         removeHeadList();
      }
      
      private function removeHeadList() : void
      {
         var _loc1_:BaseIconView = null;
         headHbox.removeAllChild();
         if(headList)
         {
            while(headList.length)
            {
               _loc1_ = headList.pop() as BaseIconView;
               _loc1_.removeEventListener("click",__removeChildFromListHandler);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
      
      private function refreshBottomText() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:ChildData = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = int(model.childList.length);
         if(levelUpConfigInfo)
         {
            _loc3_ = parseInt(levelUpConfigInfo.ConfigValue);
         }
         if(_type == ChildFunType.QATROL || _type == ChildFunType.UP_LEVEL)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = model.childList[_loc2_];
               _loc4_ += int(Math.ceil(_loc5_.growthGrade / 3.5)) * _loc5_.growthGrade;
               _loc2_++;
            }
            _loc6_ = _loc3_ * _loc4_;
            levelUpText.htmlText = LanguageMgr.GetTranslation("ChildPatrolBottomView.levelUpText.Text",_loc6_);
            patrolBtn.visible = true;
         }
         else if(_type == ChildFunType.TASK)
         {
            if(_data.patrolEndTime > playerModel.sysSecond)
            {
               restTimeText.text = "";
            }
            else
            {
               _loc3_ = Number(model.getTaskNeedTimeByChildList(_data,model.childList));
               restTimeText.text = DateFormatter.getConsortiaCountDate(_loc3_);
            }
         }
      }
      
      private function __removeChildFromListHandler(param1:MouseEvent) : void
      {
         var _loc3_:ChildData = null;
         if(_type == ChildFunType.QATROL || _type == ChildFunType.UP_LEVEL)
         {
            if(_data.onGarrison)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert1"));
               return;
            }
         }
         else if(_type == ChildFunType.TASK)
         {
            if(_data.state == 1 || _data.state == 2)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert2"));
               return;
            }
            if(_data.state != 0)
            {
               return;
            }
         }
         else if(_type == ChildFunType.EXPLORE)
         {
            if(_data.exploreLeftTime > 0)
            {
               if(_data.exploreChildId > 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert3"));
                  return;
               }
            }
            else if(_data.exploreChildId > 0)
            {
               return;
            }
         }
         var _loc2_:BaseIconView = param1.currentTarget as BaseIconView;
         if(headList.indexOf(_loc2_) != -1)
         {
            _loc3_ = model.childList[headList.indexOf(_loc2_)];
            ChildPatrolManager.instance.sendDispatchEvent("SELECT_DEL_CHILDPATROL",_loc3_);
            _loc2_.removeEventListener("click",__removeChildFromListHandler);
            model.childList.splice(headList.indexOf(_loc2_),1);
            model.childIdList.splice(headList.indexOf(_loc2_),1);
            headList.splice(headList.indexOf(_loc2_),1);
            headHbox.removeChild(_loc2_);
            _loc2_ = null;
            refreshBottomText();
            updateBottomList();
         }
      }
      
      private function __addChildToListHandler(param1:ChildPatrolEvent) : void
      {
         var _loc3_:ChildData = param1.data as ChildData;
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("ChildPatrolBottomView.headIcon");
         _loc2_.addEventListener("click",__removeChildFromListHandler);
         headHbox.addChild(_loc2_);
         headList.push(_loc2_);
         model.childList.push(_loc3_);
         model.childIdList.push(_loc3_.childId);
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
         if(_loc4_)
         {
            _loc2_.icon = PathManager.info.ResourcePath + "icon" + _loc4_.Icon;
            _loc2_.buttonMode = true;
         }
         refreshBottomText();
         updateBottomList();
      }
      
      private function updateBottomList() : void
      {
         ChildPatrolManager.instance.sendDispatchEvent("UPDATE_BOTTOM_CHILDLIST",model.childList);
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         switch(param1)
         {
            case ChildFunType.QATROL:
               patrolBtn.iconStyle = "asset.ChildPatrolBottomView.patrolBtnTxt1";
               patrolBtn.iconInnerRectString = "32,57,10,29,13";
               break;
            case ChildFunType.UP_LEVEL:
               patrolBtn.iconStyle = "asset.ChildPatrolBottomView.patrolBtnTxt1";
               patrolBtn.iconInnerRectString = "32,57,10,29,13";
               break;
            case ChildFunType.TASK:
               patrolBtn.iconStyle = "asset.ChildPatrolBottomView.patrolBtnTxt2";
               patrolBtn.iconInnerRectString = "14,89,10,29,13";
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(patrolBtn)
         {
            ObjectUtils.disposeObject(patrolBtn);
         }
         patrolBtn = null;
         if(cancelBtn)
         {
            ObjectUtils.disposeObject(cancelBtn);
         }
         cancelBtn = null;
         if(getRewardBtn)
         {
            ObjectUtils.disposeObject(getRewardBtn);
         }
         getRewardBtn = null;
         if(levelUpText)
         {
            ObjectUtils.disposeObject(levelUpText);
         }
         levelUpText = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(restTimeText)
         {
            ObjectUtils.disposeObject(restTimeText);
         }
         restTimeText = null;
         if(leftTimeText)
         {
            ObjectUtils.disposeObject(leftTimeText);
         }
         leftTimeText = null;
         if(alertText)
         {
            ObjectUtils.disposeObject(alertText);
         }
         alertText = null;
         if(exploreBtn)
         {
            ObjectUtils.disposeObject(exploreBtn);
         }
         exploreBtn = null;
         if(cancelExploreBtn)
         {
            ObjectUtils.disposeObject(cancelExploreBtn);
         }
         cancelExploreBtn = null;
         if(exploreTimeTilte)
         {
            ObjectUtils.disposeObject(exploreTimeTilte);
         }
         exploreTimeTilte = null;
         if(taskTip)
         {
            ObjectUtils.disposeObject(taskTip);
         }
         taskTip = null;
         if(headHbox)
         {
            removeHeadList();
            ObjectUtils.disposeObject(headHbox);
            headHbox = null;
         }
         if(headBackHbox)
         {
            ObjectUtils.disposeObject(headBackHbox);
         }
         headBackHbox = null;
         for each(var _loc1_:BaseIconView in headList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         headList = null;
         _data = null;
         levelUpConfigInfo = null;
         model.childList = [];
         model.childIdList = [];
         super.dispose();
      }
   }
}

