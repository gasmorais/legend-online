package skyboxroad.staypoint
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyBoxRoadPointInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SkyBoxRoadTimeRewardInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.component.TileContainer;
   
   public class SkyBoxRoadStayPointItem extends Component
   {
      
      private var back:MutipleImage;
      
      private var showAvatar:ShowAvatar;
      
      private var pointNameTxt:FilterFrameText;
      
      private var pointServerTxt:FilterFrameText;
      
      private var stayTimeTxt:FilterFrameText;
      
      private var timeImage:ScaleFrameImage;
      
      private var rewardAlertText:FilterFrameText;
      
      private var exitBtn:BaseButton;
      
      private var enterBtn:BaseButton;
      
      private var robBtn:BaseButton;
      
      private var rewardContiner:TileContainer;
      
      private var _timer:TimerTicker;
      
      private var _timeCount:int;
      
      private var posIndex:int;
      
      private var _data:SkyBoxRoadPointInfo;
      
      public function SkyBoxRoadStayPointItem(param1:int)
      {
         super();
         posIndex = param1;
         initView();
         initRewardView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.back");
         showAvatar = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadStayPointItem.showAvatar");
         pointNameTxt = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.stagnatNameTxt");
         pointServerTxt = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.stagnatServerNameTxt");
         stayTimeTxt = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.stagnatTimeTxt");
         timeImage = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.timeRewardImage");
         rewardAlertText = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.rewardAlertText");
         rewardContiner = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadStayPointItem.rewardContiner");
         exitBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.exitBtn");
         enterBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.enterBtn");
         robBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointItem.robBtn");
         addChild(back);
         addChild(showAvatar);
         addChild(pointNameTxt);
         addChild(pointServerTxt);
         addChild(exitBtn);
         addChild(enterBtn);
         addChild(robBtn);
         addChild(stayTimeTxt);
         stayTimeTxt.text = "00:00:00";
         addChild(timeImage);
         timeImage.setFrame(posIndex);
         addChild(rewardAlertText);
         addChild(rewardContiner);
         rewardAlertText.text = LanguageMgr.GetTranslation("SkyBoxRoadStayPointItem.rewardAlertText.text");
      }
      
      private function initRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc5_:SkyBoxRoadTimeRewardInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc1_:Array = TempleteManager.instance.skyBoxRoadTimeRewardTempCate.getListByCampaignId(model.currentPortalId,posIndex);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadStayPointItem.rewardItem");
            _loc5_ = _loc1_[_loc4_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc5_.TemplateId;
            _loc6_.count = _loc5_.Count;
            _loc2_.data = _loc6_;
            rewardContiner.appendItem(_loc2_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         exitBtn.addEventListener("click",__exitBtnClickHandler);
         exitBtn.addEventListener("mouseOver",__btnOverHandler);
         exitBtn.addEventListener("mouseOut",__btnOutHandler);
         enterBtn.addEventListener("click",__enterBtnClickHandler);
         enterBtn.addEventListener("mouseOver",__btnOverHandler);
         enterBtn.addEventListener("mouseOut",__btnOutHandler);
         robBtn.addEventListener("click",__enterBtnClickHandler);
         robBtn.addEventListener("mouseOver",__btnOverHandler);
         robBtn.addEventListener("mouseOut",__btnOutHandler);
      }
      
      private function removeEvent() : void
      {
         if(exitBtn)
         {
            exitBtn.removeEventListener("click",__exitBtnClickHandler);
            exitBtn.removeEventListener("mouseOver",__btnOverHandler);
            exitBtn.removeEventListener("mouseOut",__btnOutHandler);
         }
         if(enterBtn)
         {
            enterBtn.removeEventListener("click",__enterBtnClickHandler);
            enterBtn.removeEventListener("mouseOver",__btnOverHandler);
            enterBtn.removeEventListener("mouseOut",__btnOutHandler);
         }
         if(robBtn)
         {
            robBtn.removeEventListener("click",__enterBtnClickHandler);
            robBtn.removeEventListener("mouseOver",__btnOverHandler);
            robBtn.removeEventListener("mouseOut",__btnOutHandler);
         }
      }
      
      private function __btnOverHandler(param1:MouseEvent) : void
      {
         if(exitBtn.visible)
         {
            exitBtn.backStyle = "asset.SkyBoxRoadStayPointItem.exitOverBtn";
         }
         if(enterBtn.visible)
         {
            enterBtn.backStyle = "asset.SkyBoxRoadStayPointItem.enterOverBtn";
         }
         if(robBtn.visible)
         {
            robBtn.backStyle = "asset.SkyBoxRoadStayPointItem.robOverBtn";
         }
      }
      
      private function __btnOutHandler(param1:MouseEvent) : void
      {
         if(exitBtn.visible)
         {
            exitBtn.backStyle = "asset.SkyBoxRoadStayPointItem.exitOutBtn";
         }
         if(enterBtn.visible)
         {
            enterBtn.backStyle = "asset.SkyBoxRoadStayPointItem.enterOutBtn";
         }
         if(robBtn.visible)
         {
            robBtn.backStyle = "asset.SkyBoxRoadStayPointItem.robOutBtn";
         }
      }
      
      private function __exitBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [exitResultHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("skysecretareaView.exploreViewTips03");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function exitResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SkyboxRoadManager.instance.sendPointOccupyRequest(11,model.currentPortalId,posIndex);
         }
      }
      
      private function __enterBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:Boolean = false;
         if(param1.currentTarget is BaseButton && param1.currentTarget.stylename == "SkyBoxRoadStayPointItem.robBtn")
         {
            _loc4_ = true;
         }
         if(model.isOccpPoint)
         {
            SimpleAlertHelper.instance.data = [enterResultHandler,_loc4_];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("skysecretareaView.stagnatViewTips05");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
         }
         else if(!resultRobAlert(_loc4_))
         {
            SkyboxRoadManager.instance.sendPointOccupyRequest(9,model.currentPortalId,posIndex);
         }
      }
      
      private function enterResultHandler(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!resultRobAlert(param3))
         {
            SkyboxRoadManager.instance.sendPointOccupyRequest(9,model.currentPortalId,posIndex);
         }
      }
      
      private function resultRobAlert(param1:Boolean) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!param1)
         {
            return false;
         }
         var _loc4_:Boolean = playerModel.sysCurtime.day == 0 ? true : false;
         var _loc5_:Boolean = playerModel.sysCurtime.hours == 23 ? true : false;
         var _loc8_:Boolean = playerModel.sysCurtime.minutes >= 50 ? true : false;
         if(_loc4_ && _loc5_ && _loc8_)
         {
            SimpleAlertHelper.instance.data = [endRobResultHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("skysecretareaView.stagnatView.timeEndAlert");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            return true;
         }
         return false;
      }
      
      private function endRobResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         SkyboxRoadManager.instance.sendPointOccupyRequest(9,model.currentPortalId,posIndex);
      }
      
      public function get data() : SkyBoxRoadPointInfo
      {
         return _data;
      }
      
      public function set data(param1:SkyBoxRoadPointInfo) : void
      {
         _data = param1;
         clean();
         setBtnState();
         if(_data)
         {
            refreshView();
         }
      }
      
      private function clean() : void
      {
         showAvatar.data = null;
         pointNameTxt.text = "";
         pointServerTxt.text = "";
         stayTimeTxt.text = "";
         cleanTimer();
      }
      
      private function cleanTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timeHandler);
            _timer = null;
         }
      }
      
      private function setBtnState() : void
      {
         if(data)
         {
            if(data.occpUserId == playerModel.playerInfo.userId && data.svrsName == playerModel.playerInfo.serviceName)
            {
               exitBtn.visible = true;
               enterBtn.visible = false;
               robBtn.visible = false;
            }
            else
            {
               exitBtn.visible = false;
               enterBtn.visible = false;
               robBtn.visible = true;
            }
         }
         else
         {
            enterBtn.visible = true;
            exitBtn.visible = false;
            robBtn.visible = false;
         }
      }
      
      private function refreshView() : void
      {
         showAvatar.data = data.userInfo;
         pointNameTxt.text = data.nickName;
         pointServerTxt.text = data.svrsName;
         timeTick();
      }
      
      private function timeTick() : void
      {
         if(_timer == null)
         {
            _timer = new TimerTicker(1000);
            _timer.addEventListener("timer",__timeHandler);
            _timer.start();
         }
         _timeCount = 0;
         __timeHandler(null);
      }
      
      private function __timeHandler(param1:TimerEvent) : void
      {
         var _loc2_:Number = Number(playerModel.sysCurtime.time);
         var _loc3_:Number = Number(DateFormatter.parse(data.occpDateStr,"YYYY-MM-DD hh:mm:ss").time);
         var _loc4_:int = (_loc2_ - _loc3_) / 1000;
         _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
         stayTimeTxt.text = DateFormatter.getConsortiaCountDate(_loc4_);
         _timeCount += 1;
         if(_timeCount >= 2)
         {
            _timeCount = 0;
         }
      }
      
      override public function get width() : Number
      {
         return 270;
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         cleanTimer();
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(showAvatar);
         showAvatar = null;
         ObjectUtils.disposeObject(pointNameTxt);
         pointNameTxt = null;
         ObjectUtils.disposeObject(pointServerTxt);
         pointServerTxt = null;
         ObjectUtils.disposeObject(stayTimeTxt);
         stayTimeTxt = null;
         ObjectUtils.disposeObject(timeImage);
         timeImage = null;
         ObjectUtils.disposeObject(exitBtn);
         exitBtn = null;
         ObjectUtils.disposeObject(enterBtn);
         enterBtn = null;
         ObjectUtils.disposeObject(robBtn);
         robBtn = null;
         ObjectUtils.disposeObject(rewardContiner);
         rewardContiner = null;
         ObjectUtils.disposeObject(rewardAlertText);
         rewardAlertText = null;
         super.dispose();
      }
   }
}

