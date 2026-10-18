package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.SortController;
   import mvc.module.sort.SortData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseIconView;
   
   public class PvpHeroFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _titleBg:MutipleImage;
      
      private var _para0:FilterFrameText;
      
      private var _para1:FilterFrameText;
      
      private var _para2:FilterFrameText;
      
      private var _para3:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      private var _weekAddList:Array;
      
      private var _help:BaseButton;
      
      private var _lastUpdateTxt:FilterFrameText;
      
      private var _mySortBg:ScaleBitmapImage;
      
      private var _mySortImg:Bitmap;
      
      private var _sortImg:Bitmap;
      
      private var _jifenImg:Bitmap;
      
      private var _rewardImg:Bitmap;
      
      private var _txtBg1:ScaleLeftRightImage;
      
      private var _txtBg2:ScaleLeftRightImage;
      
      private var _para4:FilterFrameText;
      
      private var _para5:FilterFrameText;
      
      private var _para6:FilterFrameText;
      
      private var _rewardBg:Bitmap;
      
      private var _rewardIcon:BaseIconView;
      
      private var _createDate:Date;
      
      private var _playerInfo:PlayerInfo;
      
      public var preFrame:String;
      
      public function PvpHeroFrame()
      {
         super();
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         initView();
         addEvent();
         loadData();
      }
      
      protected function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("PvpSelectFrame.FrameBack");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("PvpHeroFrame.Title");
         _para0 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para1 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para2 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para3 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("PvpHeroFrame.ListPanel");
         _help = ComponentFactory.Instance.creatComponentByStylename("worldboss.FriendList.help");
         _mySortBg = ComponentFactory.Instance.creatComponentByStylename("PvpSelectFrame.FrameBack2");
         _mySortImg = ComponentFactory.Instance.creatBitmap("asset.sort.MySortImg");
         _sortImg = ComponentFactory.Instance.creatBitmap("asset.sort.SortTxtImg");
         _jifenImg = ComponentFactory.Instance.creatBitmap("asset.sort.JifenTxtImg");
         _rewardImg = ComponentFactory.Instance.creatBitmap("asset.sort.Reward");
         _txtBg1 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg1");
         _txtBg2 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg2");
         _para4 = ComponentFactory.Instance.creatComponentByStylename("sort.lastUpdateTimeText1");
         _para5 = ComponentFactory.Instance.creatComponentByStylename("sort.MySortTextStyle1");
         _para6 = ComponentFactory.Instance.creatComponentByStylename("sort.MySortTextStyle2");
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.sort.RewardIconBg");
         _rewardIcon = ComponentFactory.Instance.creatCustomObject("pvpHerosFrame.RewardIconView");
         _help.x = 493;
         _help.y = -30;
         _border.x = 5;
         _border.y = 14;
         _border.width = 538;
         _border.height = 308;
         _para0.y = _para1.y = _para2.y = _para3.y = 24;
         _para0.x = 38;
         _para1.x = 166;
         _para2.x = 254;
         _para3.x = 428;
         _para0.text = LanguageMgr.GetTranslation("PvpHeroFrame.PlayerName");
         _para1.text = LanguageMgr.GetTranslation("PvpSortListView.serverName");
         _para2.text = LanguageMgr.GetTranslation("PvpHeroFrame.Kill");
         _para3.text = LanguageMgr.GetTranslation("PvpHeroFrame.Honor");
         this.titleText = LanguageMgr.GetTranslation("PvpHeroFrame.Title");
         _help.tipData = LanguageMgr.GetTranslation("pvpHeroHelperFrame.title");
         addToContent(_border);
         addToContent(_titleBg);
         addToContent(_para0);
         addToContent(_para1);
         addToContent(_para2);
         addToContent(_para3);
         addToContent(_listPanel);
         addToContent(_help);
         addToContent(_mySortBg);
         addToContent(_mySortImg);
         addToContent(_sortImg);
         addToContent(_jifenImg);
         addToContent(_txtBg1);
         addToContent(_txtBg2);
         addToContent(_para4);
         addToContent(_para5);
         addToContent(_para6);
         addToContent(_rewardImg);
         addToContent(_rewardBg);
         addToContent(_rewardIcon);
         _mySortImg.x = 10;
         _mySortImg.y = 325;
         _sortImg.x = 27;
         _sortImg.y = 355;
         _jifenImg.x = 264;
         _jifenImg.y = 355;
         _txtBg1.x = 60;
         _txtBg1.y = 350;
         _txtBg2.x = 316;
         _txtBg2.y = 350;
         _txtBg2.width = 100;
         _para4.x = 270;
         _para4.y = 327;
         _para5.x = 73;
         _para5.y = 354;
         _para6.x = 320;
         _para6.y = 354;
         _rewardImg.x = 412;
         _rewardImg.y = 355;
         _rewardBg.x = 482;
         _rewardBg.y = 326;
         _rewardIcon.icon = ComponentFactory.Instance.creatBitmap("asset.sort.RewardIcon");
         _rewardIcon.tipData = LanguageMgr.GetTranslation("pvpHeroFrame.rewardTip");
      }
      
      protected function addEvent() : void
      {
         if(_help)
         {
            _help.addEventListener("click",__helpClick);
         }
         addEventListener("response",__frameResponse);
      }
      
      protected function removeEvent() : void
      {
         if(_help)
         {
            _help.removeEventListener("click",__helpClick);
         }
         removeEventListener("response",__frameResponse);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("worldboss.PvpHeroHelperFrame");
         _loc2_["show"]();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               switch(preFrame)
               {
                  case "worldboss":
                     FrameControllerManager.instance.openControllerByInfo("worldboss",3);
                     break;
                  case "pvproomlist":
                     FrameControllerManager.instance.openControllerByInfo("pvproomlist");
               }
               dispose();
         }
      }
      
      private function loadData() : void
      {
         var _loc1_:String = PathManager.orderPath + "cross/crossscore.xml";
         LoaderManagerII.instance.load(_loc1_,5,8,__onDataLoaded);
      }
      
      private function __onDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         resolveXML(new XML(param2));
         bindData();
      }
      
      private function resolveXML(param1:XML) : void
      {
         var _loc2_:* = null;
         var _loc3_:SortData = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         _createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _createDate.setHours(3,0,0,0);
         _weekAddList = [];
         var _loc5_:XMLList = param1..CrossScoreTotalAdd;
         for each(_loc2_ in _loc5_)
         {
            _loc3_ = SortController.read(_loc2_);
            if(_weekAddList.length < 20)
            {
               _weekAddList.push(_loc3_);
            }
         }
      }
      
      private function bindData() : void
      {
         _weekAddList.sortOn("orderId",16);
         var _loc2_:int = -1;
         _listPanel.beginChanges();
         for each(var _loc1_:SortData in _weekAddList)
         {
            _listPanel.vectorListModel.append(_loc1_);
            if(_loc1_.nikcName == _playerInfo.nickName && _loc1_.serverName == _playerInfo.serviceName && _loc1_.army.baseHero.userId == _playerInfo.userId)
            {
               _loc2_ = _loc1_.orderId;
            }
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         var _loc3_:String = _createDate ? DateFormatter.format(_createDate,"MM-DD hh:mm") : "";
         _para4.text = LanguageMgr.GetTranslation("sort.view.SortRightView.lastUpdateTime") + _loc3_;
         if(_loc2_ == -1)
         {
            _para5.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         else
         {
            _para5.text = _loc2_.toString();
         }
         _para6.text = String(_playerInfo.crossScore);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_rewardIcon);
         _rewardIcon = null;
         ObjectUtils.disposeObject(_rewardImg);
         _rewardImg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         super.dispose();
         _border = null;
         _titleBg = null;
         _para0 = null;
         _para1 = null;
         _para2 = null;
         _para3 = null;
         _listPanel = null;
         _help = null;
         _mySortBg = null;
         _mySortImg = null;
         _sortImg = null;
         _jifenImg = null;
         _txtBg1 = null;
         _txtBg2 = null;
         _para4 = null;
         _para5 = null;
         _para6 = null;
         preFrame = null;
         _playerInfo = null;
      }
   }
}

