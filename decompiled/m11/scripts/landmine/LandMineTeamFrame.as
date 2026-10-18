package landmine
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FreedomTeamEvent;
   import events.LandMineEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import mvc.module.landmine.LandMineModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.LandMineManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class LandMineTeamFrame extends Frame
   {
      
      private var _frameBg:Image;
      
      private var _heroView1:LandMineTeamHeroView;
      
      private var _heroView2:LandMineTeamHeroView;
      
      private var _heroView3:LandMineTeamHeroView;
      
      private var _heroView4:LandMineTeamHeroView;
      
      private var _heroViewList:Vector.<LandMineTeamHeroView>;
      
      private var _leftTimeTxt:Image;
      
      private var _leftTimeValueTxt:FilterFrameText;
      
      private var _rewardTitleTxt:Image;
      
      private var _helpTitleTxt:Image;
      
      private var _helpContentTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _itemContainer:Sprite;
      
      private var _waitView:LandMineTeamWaitView;
      
      private var _model:LandMineModel = LandMineManager.instance.model;
      
      private var _preClickTime:Number;
      
      public function LandMineTeamFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         LandMineManager.instance.team();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("landmine.LandMineTeamFrame.TitleTxt");
         _frameBg = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.frameBg");
         _heroView1 = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.heroView1");
         _heroView2 = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.heroView2");
         _heroView3 = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.heroView3");
         _heroView4 = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.heroView4");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.leftTimeTxt");
         _leftTimeValueTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.leftTimeValueTxt");
         _rewardTitleTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.rewardTitleTxt");
         _helpTitleTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.helpTitleTxt");
         _helpContentTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.helpContentTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamFrame.startBtn");
         _itemContainer = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.itemContainer");
         _leftTimeValueTxt.text = LanguageMgr.GetTranslation("landmine.LandMineTeamFrame.LeftTimeValueTxt",1,_model.maxRewardCount);
         _helpContentTxt.text = LanguageMgr.GetTranslation("landmine.LandMineTeamFrame.HelpContentTxt");
         _heroViewList = new Vector.<LandMineTeamHeroView>();
         _heroViewList.push(_heroView1);
         _heroViewList.push(_heroView2);
         _heroViewList.push(_heroView3);
         _heroViewList.push(_heroView4);
         addToContent(_frameBg);
         addToContent(_heroView1);
         addToContent(_heroView2);
         addToContent(_heroView3);
         addToContent(_heroView4);
         addToContent(_leftTimeTxt);
         addToContent(_leftTimeValueTxt);
         addToContent(_rewardTitleTxt);
         addToContent(_helpTitleTxt);
         addToContent(_helpContentTxt);
         addToContent(_startBtn);
         addToContent(_itemContainer);
         initRewardItems();
      }
      
      private function initRewardItems() : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         var _loc1_:int = int(_model.itemsIdArray.length);
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = int(_model.itemsIdArray[_loc4_]);
            _loc3_ = int(_model.itemsCountArray[_loc4_]);
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc5_;
            _loc6_.count = _loc3_;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamFrame.rewardItemView");
            _loc2_.x = _loc4_ * 99;
            _loc2_.data = _loc6_;
            _itemContainer.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_frameBg);
         _frameBg = null;
         ObjectUtils.disposeObject(_heroView1);
         _heroView1 = null;
         ObjectUtils.disposeObject(_heroView2);
         _heroView2 = null;
         ObjectUtils.disposeObject(_heroView3);
         _heroView3 = null;
         ObjectUtils.disposeObject(_heroView4);
         _heroView4 = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_leftTimeValueTxt);
         _leftTimeValueTxt = null;
         ObjectUtils.disposeObject(_rewardTitleTxt);
         _rewardTitleTxt = null;
         ObjectUtils.disposeObject(_helpTitleTxt);
         _helpTitleTxt = null;
         ObjectUtils.disposeObject(_helpContentTxt);
         _helpContentTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeObject(_waitView);
         _waitView = null;
         LogicUtils.disposeDisplayCollection(_heroViewList);
         _heroViewList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _model.addEventListener("INFO_UPDATE",__infoUpdateHandler);
         _model.addEventListener("TEAM_CANCEL",__teamCancelHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         _model.removeEventListener("INFO_UPDATE",__infoUpdateHandler);
         _model.removeEventListener("TEAM_CANCEL",__teamCancelHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         LandMineManager.instance.team();
         refreshStartBtn();
      }
      
      private function __teamCancelHandler(param1:LandMineEvent) : void
      {
         ObjectUtils.disposeObject(_waitView);
         _waitView = null;
      }
      
      private function __infoUpdateHandler(param1:LandMineEvent) : void
      {
         refreshHeroView();
         refreshRewardCount();
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc5_:Number = getTimer();
         if(_loc5_ - _preClickTime < 2000)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _preClickTime = _loc5_;
         if(!FreedomTeamManager.instance.hasTeam || FreedomTeamManager.instance.hasTeam && FreedomTeamManager.instance.model.allMembers.length < 4)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("landmine.LandMineTeamFrame.TipsTxt01");
            SimpleAlertHelper.instance.data = [startCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            return;
         }
         enter();
      }
      
      private function startCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            enter();
         }
      }
      
      private function showWaitView() : void
      {
         _waitView = new LandMineTeamWaitView(waitViewCallBack);
         _waitView.timeCount = 10;
         _waitView.show();
      }
      
      private function enter() : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            showWaitView();
         }
         LandMineManager.instance.enter();
      }
      
      private function waitViewCallBack() : void
      {
         _waitView = null;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refreshHeroView() : void
      {
         var _loc1_:LandMineTeamHeroView = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_heroViewList.length);
         var _loc3_:Array = _model.sapperDic.getList();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _heroViewList[_loc4_];
            if(_loc4_ < _loc3_.length)
            {
               _loc1_.data = _loc3_[_loc4_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function refreshRewardCount() : void
      {
         var _loc1_:int = _model.maxRewardCount - _model.rewardCount;
         _leftTimeValueTxt.text = LanguageMgr.GetTranslation("landmine.LandMineTeamFrame.LeftTimeValueTxt",_loc1_,_model.maxRewardCount);
      }
      
      private function refreshStartBtn() : void
      {
         var _loc1_:Boolean = true;
         if(FreedomTeamManager.instance.hasTeam && !FreedomTeamManager.instance.isCaptain)
         {
            _loc1_ = false;
         }
         _startBtn.enable = _loc1_;
      }
      
      private function refreshView() : void
      {
         refreshRewardCount();
         refreshStartBtn();
         refreshHeroView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

