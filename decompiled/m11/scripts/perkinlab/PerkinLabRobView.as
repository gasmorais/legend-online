package perkinlab
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PerkinLabEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.PerkinLabManager;
   import managers.VIPManager;
   import mvc.module.perkinlab.PerkinLabKengInfo;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class PerkinLabRobView extends Component
   {
      
      private var robBack:Bitmap;
      
      private var robText:FilterFrameText;
      
      private var cdTxt:GradientText;
      
      private var coolDownBtn:BaseButton;
      
      private var itemList:Vector.<PerkinLabKengView>;
      
      private var refrshBtn:IconButton;
      
      private var refreshText:FilterFrameText;
      
      private var refreshTime:TimeDownView;
      
      private var refreshMc:MovieClip;
      
      private var victoryContiner:Component;
      
      private var victoryMc:MovieClip;
      
      private var _cdTimer:TimerTicker;
      
      private var robMaxCount:int;
      
      private var robCost:int;
      
      private var victoryConfigInfo:ConfigInfosTempInfo;
      
      private var _lastClickTime:int = 0;
      
      public function PerkinLabRobView()
      {
         super();
         robMaxCount = ConfigInfoManager.instance.getPerkibnRobMaxCount();
         robCost = ConfigInfoManager.instance.getPerkinRobCdCost();
         initView();
         initKengView();
         addEvent();
         PerkinLabManager.instance.sendLabOperate(1);
      }
      
      private function initView() : void
      {
         robBack = ComponentFactory.Instance.creatBitmap("asset.PerkinLabRobView.robBack");
         robText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.robText");
         cdTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.cdTxt");
         coolDownBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.coolDownBtn");
         refrshBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.refrshBtn");
         refreshText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.refreshText");
         refreshTime = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.UpdateTime");
         refreshMc = ComponentFactory.Instance.creatCustomObject("PerkinLabRobView.refreshMc");
         victoryContiner = ComponentFactory.Instance.creatComponentByStylename("PerkinLabRobView.victoryContiner");
         victoryMc = ComponentFactory.Instance.creatCustomObject("PerkinLabRobView.victoryMc");
         addChild(robBack);
         addChild(robText);
         addChild(cdTxt);
         cdTxt.text = "";
         addChild(coolDownBtn);
         coolDownBtn.visible = false;
         addChild(victoryContiner);
         victoryContiner.addChild(victoryMc);
         victoryMc.gotoAndStop(1);
         addChild(refrshBtn);
         addChild(refreshText);
         addChild(refreshTime);
         _cdTimer = new TimerTicker(1000);
         refreshText.text = LanguageMgr.GetTranslation("PerkinLabRobView.refreshText.text");
         victoryConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("perkin_lab_winning_streak_reward");
      }
      
      private function initKengView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PerkinLabKengView = null;
         itemList = new Vector.<PerkinLabKengView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PerkinLabKengView(1);
            _loc1_.x = model.kengPosArr[_loc2_][0];
            _loc1_.y = model.kengPosArr[_loc2_][1];
            addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         PerkinLabManager.instance.addEventListener("UPDATE_ROB_LIST",__updateRobView);
         refrshBtn.addEventListener("click",__refreshClickHandler);
         refreshTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         coolDownBtn.addEventListener("click",__coolDownHandler);
      }
      
      private function __coolDownHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc4_:VipCoolDownFrame = null;
         var _loc7_:String = null;
         var _loc9_:String = null;
         var _loc2_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         if(model.robCdTime <= 0)
         {
            return;
         }
         if(VIPManager.Instance.model.vipCoolPrivilege)
         {
            _loc3_ = 2;
            if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
            {
               _loc3_ = 0;
            }
            PerkinLabManager.instance.sendLabOperate(10,_loc3_);
         }
         else
         {
            _loc5_ = ConfigInfoManager.instance.getPerkinCdRobCost();
            _loc8_ = Math.ceil(model.robCdTime / (60 * _loc5_[1])) * _loc5_[0];
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc7_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc9_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc8_);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_.initData(_loc7_,_loc9_,0,_loc8_,_loc8_,coolColosseBack,_loc2_,_loc6_);
            _loc4_.show();
         }
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 1, param4:Boolean = true) : void
      {
         var _loc5_:int = 0;
         if(model.robCdTime <= 0)
         {
            return;
         }
         if(param1)
         {
            _loc5_ = param4 ? 2 : 1;
            if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
            {
               _loc5_ = 0;
            }
            PerkinLabManager.instance.sendLabOperate(10,_loc5_);
         }
      }
      
      private function __refreshClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc3_:int = getTimer();
         if(_loc3_ - _lastClickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc3_;
         SoundManager.instance.play("022");
         var _loc4_:int = int(ResourceManager.instance.gold.count);
         if(_loc4_ >= model.refreshCost)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_ = LanguageMgr.GetTranslation("perkinlab.PerkinLabRobView.refreshAlert.alertText",model.refreshCost);
            SharedManagerHelper.ins.needAlert("perkinlab.PerkinLabRobView.refreshAlert",refreshResultHandler,_loc2_,_loc5_);
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
      }
      
      private function refreshResultHandler() : void
      {
         PerkinLabManager.instance.sendLabOperate(6);
         refreshHanlder();
      }
      
      private function refreshHanlder() : void
      {
         addChild(refreshMc);
         refreshMc.gotoAndPlay(1);
         refreshMc.addFrameScript(refreshMc.totalFrames - 1,function():void
         {
            ObjectUtils.disposeViolentMc(refreshMc);
            PerkinLabManager.instance.sendLabOperate(7);
         });
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         PerkinLabManager.instance.sendLabOperate(9);
         refreshHanlder();
      }
      
      private function __updateRobView(param1:PerkinLabEvent) : void
      {
         if(_cdTimer.hasEventListener("timer") == false)
         {
            _cdTimer.addEventListener("timer",__timerhandler);
         }
         _cdTimer.reset();
         _cdTimer.start();
         refreshView(param1.data as PerkinLabKengInfo);
      }
      
      private function __timerhandler(param1:TimerEvent) : void
      {
         model.robCdTime--;
         if(model.robCdTime <= 0)
         {
            cdTxt.text = "";
            coolDownBtn.visible = false;
            cleanTimer();
            return;
         }
         cdTxt.text = DateFormatter.getConsortiaCountDate(int(model.robCdTime));
         coolDownBtn.visible = true;
      }
      
      private function cleanTimer() : void
      {
         if(_cdTimer)
         {
            _cdTimer.removeEventListener("timer",__timerhandler);
            _cdTimer.stop();
         }
      }
      
      private function refreshView(param1:PerkinLabKengInfo) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = robMaxCount - model.robCount;
         robText.htmlText = LanguageMgr.GetTranslation("PerkinLabRobView.robText.text",_loc7_,robMaxCount);
         refreshTime.timeCount = model.nextRefreshTime - PlayerManager.instance.currentPlayerModel.sysSecond;
         itemList[param1.index].data = param1;
         if(victoryConfigInfo)
         {
            _loc4_ = victoryConfigInfo.ConfigValue.split("#");
            _loc5_ = int(_loc4_[0]);
            _loc2_ = (_loc4_[1] as String).split(",");
            if(model.victoryCount >= _loc2_.length - 1)
            {
               _loc8_ = victoryMc.totalFrames;
               _loc3_ = int(_loc2_[_loc2_.length - 1]);
            }
            else
            {
               _loc8_ = model.victoryCount * victoryMc.totalFrames / (_loc2_.length - 1);
               _loc3_ = int(_loc2_[model.victoryCount]);
            }
            victoryMc.gotoAndStop(_loc8_);
            _loc6_ = {};
            _loc6_.victoryCount = model.victoryCount;
            _loc6_.tempId = _loc5_;
            _loc6_.count = _loc3_;
            victoryContiner.tipData = _loc6_;
         }
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function removeEvent() : void
      {
         PerkinLabManager.instance.removeEventListener("UPDATE_ROB_LIST",__updateRobView);
         refrshBtn.removeEventListener("click",__refreshClickHandler);
         refreshTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         coolDownBtn.removeEventListener("click",__coolDownHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanTimer();
         _cdTimer = null;
         if(robBack)
         {
            ObjectUtils.disposeObject(robBack);
         }
         robBack = null;
         if(robText)
         {
            ObjectUtils.disposeObject(robText);
         }
         robText = null;
         if(refrshBtn)
         {
            ObjectUtils.disposeObject(refrshBtn);
         }
         refrshBtn = null;
         if(refreshText)
         {
            ObjectUtils.disposeObject(refreshText);
         }
         refreshText = null;
         if(refreshTime)
         {
            ObjectUtils.disposeObject(refreshTime);
         }
         refreshTime = null;
         if(refreshMc)
         {
            ObjectUtils.disposeViolentMc(refreshMc);
         }
         refreshMc = null;
         if(victoryMc)
         {
            ObjectUtils.disposeViolentMc(victoryMc);
         }
         victoryMc = null;
         if(victoryContiner)
         {
            ObjectUtils.disposeObject(victoryContiner);
         }
         victoryContiner = null;
         if(victoryMc)
         {
            ObjectUtils.disposeViolentMc(victoryMc);
         }
         victoryMc = null;
         if(cdTxt)
         {
            ObjectUtils.disposeObject(cdTxt);
         }
         cdTxt = null;
         if(coolDownBtn)
         {
            ObjectUtils.disposeObject(coolDownBtn);
         }
         coolDownBtn = null;
         if(itemList)
         {
            for(var _loc1_:String in itemList)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
            }
            itemList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

