package map.campaign.view.ui.flametemple
{
   import chat.view.ChatItemMenu;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import map.campaign.data.WarFightOrderInfo;
   import map.campaign.data.WarReportInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.NumberViewUtils;
   
   public class FlameTempleGameOverView extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bottom:Component;
      
      private var _rewardBack:DisplayObject;
      
      private var _rewardLabel:Image;
      
      private var _scoreImg:Image;
      
      private var _scoreTxtBack:ScaleLeftRightImage;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _viewRewardsBtn:TextButton;
      
      private var _rewardA:Image;
      
      private var _rewardB:Image;
      
      private var _rewardC:Image;
      
      private var _rewardD:Image;
      
      private var _xImgA:Bitmap;
      
      private var _xImgB:Bitmap;
      
      private var _xImgC:Bitmap;
      
      private var _xImgD:Bitmap;
      
      private var _rewardNumA:Component;
      
      private var _rewardNumB:Component;
      
      private var _rewardNumC:Component;
      
      private var _rewardNumD:Component;
      
      private var _numberSheet:BitmapData;
      
      private var _failedFlg:Bitmap;
      
      private var _victoryFlg:Bitmap;
      
      private var _selectedItem:FlameTempleGameOverItemView;
      
      private var _menu:ChatItemMenu;
      
      private var _personRewardView:Frame;
      
      private var _tweenRect:Rectangle;
      
      private var _tween:TweenLite;
      
      private var _box:Sprite;
      
      private var _rect:Rectangle = new Rectangle(0,0,475,505);
      
      public function FlameTempleGameOverView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc6_:int = 0;
         var _loc1_:FilterFrameText = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverView.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverView.back");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverView.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverView.vBox");
         var _loc2_:Array = [LanguageMgr.GetTranslation("PvpHeroFrame.PlayerName"),LanguageMgr.GetTranslation("PvpSortListView.serverName"),LanguageMgr.GetTranslation("flameTempleScoreRankView.jisha2"),LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.honorBit.tipData")];
         var _loc3_:Array = [116,90,80,40];
         var _loc7_:Array = [0,180,280,365];
         var _loc4_:Component = new Component();
         _loc4_.x = 6;
         _loc4_.y = 12;
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.titleTxt");
            _loc1_.width = _loc3_[_loc6_];
            _loc1_.x = _loc7_[_loc6_];
            _loc1_.text = _loc2_[_loc6_];
            _loc4_.addChild(_loc1_);
            _loc6_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         addToContent(_border);
         addToContent(_back);
         addToContent(_scrollPanel);
         addToContent(_loc4_);
         _bottom = new Component();
         _bottom.x = 1;
         _bottom.y = 310;
         _rewardBack = ComponentFactory.Instance.creat("asset.flametemple.RankBottom");
         _rewardLabel = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.rewardLabel");
         _scoreImg = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.scoreImg");
         _scoreTxtBack = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.scoreTxtBack");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.scoreTxt");
         _viewRewardsBtn = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.viewRewardsBtn");
         _rewardA = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.rewardA");
         _rewardB = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.rewardB");
         _rewardC = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.rewardC");
         _rewardD = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.rewardD");
         var _loc5_:BitmapData = ClassUtils.CreatInstance("asset.pvpmap.SymbolAsset");
         _xImgA = new Bitmap(_loc5_);
         _xImgB = new Bitmap(_loc5_);
         _xImgC = new Bitmap(_loc5_);
         _xImgD = new Bitmap(_loc5_);
         _xImgA.x = _rewardA.x + _rewardA.width;
         _xImgB.x = _rewardB.x + _rewardB.width;
         _xImgC.x = _rewardC.x + _rewardC.width;
         _xImgD.x = _rewardD.x + _rewardD.width;
         _xImgA.y = _xImgB.y = _xImgC.y = _xImgD.y = 35;
         _rewardNumA = new Component();
         _rewardNumB = new Component();
         _rewardNumC = new Component();
         _rewardNumD = new Component();
         _rewardNumA.x = _xImgA.x + _xImgA.width - 5;
         _rewardNumB.x = _xImgB.x + _xImgB.width - 5;
         _rewardNumC.x = _xImgC.x + _xImgC.width - 5;
         _rewardNumD.x = _xImgD.x + _xImgD.width - 5;
         _rewardC.x = _rewardB.x;
         _xImgC.x = _xImgB.x;
         _rewardNumC.x = _rewardNumB.x;
         _rewardNumA.y = _rewardNumB.y = _rewardNumC.y = _rewardNumD.y = 32;
         _bottom.addChild(_rewardBack);
         _bottom.addChild(_rewardLabel);
         _bottom.addChild(_scoreImg);
         _bottom.addChild(_scoreTxtBack);
         _bottom.addChild(_scoreTxt);
         _bottom.addChild(_viewRewardsBtn);
         _bottom.addChild(_rewardA);
         _bottom.addChild(_rewardC);
         _bottom.addChild(_rewardD);
         _bottom.addChild(_xImgA);
         _bottom.addChild(_xImgC);
         _bottom.addChild(_xImgD);
         _bottom.addChild(_rewardNumA);
         _bottom.addChild(_rewardNumC);
         _bottom.addChild(_rewardNumD);
         addToContent(_bottom);
         _failedFlg = ComponentFactory.Instance.creatBitmap("asset.core.FailedBitmapAsset");
         _failedFlg.scaleX = _failedFlg.scaleY = 0.7;
         _failedFlg.x = -75;
         _failedFlg.y = 0;
         _failedFlg.rotation = -30;
         _victoryFlg = ComponentFactory.Instance.creatBitmap("asset.map.Won");
         addToContent(_failedFlg);
         addToContent(_victoryFlg);
         _numberSheet = ComponentFactory.Instance.creatBitmapData("worldboss.river.NumberAsset");
         NumberViewUtils.getNumberView(0,_rewardNumA,_numberSheet,20,23,13,20,"0123456789",1);
         NumberViewUtils.getNumberView(0,_rewardNumB,_numberSheet,20,23,13,20,"0123456789",1);
         NumberViewUtils.getNumberView(0,_rewardNumC,_numberSheet,20,23,13,20,"0123456789",1);
         NumberViewUtils.getNumberView(0,_rewardNumD,_numberSheet,20,23,13,20,"0123456789",1);
         _scoreTxt.text = "0";
         _vBox.mouseEnabled = false;
         this.titleText = LanguageMgr.GetTranslation("flametemple.heroRank");
         _viewRewardsBtn.text = LanguageMgr.GetTranslation("flametemple.viewAllRewards");
         _failedFlg.visible = false;
         _victoryFlg.visible = false;
         _rewardA.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.awardMax.tipData");
         _rewardB.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.honorBit.tipData");
         _rewardC.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.flameTempleGameOverView.tipData");
         _rewardD.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.flameTempleGameOverView.tipData2");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_rewardBack);
         _rewardBack = null;
         ObjectUtils.disposeObject(_rewardLabel);
         _rewardLabel = null;
         ObjectUtils.disposeObject(_scoreImg);
         _scoreImg = null;
         ObjectUtils.disposeObject(_scoreTxtBack);
         _scoreTxtBack = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_viewRewardsBtn);
         _viewRewardsBtn = null;
         ObjectUtils.disposeObject(_rewardA);
         _rewardA = null;
         ObjectUtils.disposeObject(_rewardB);
         _rewardB = null;
         ObjectUtils.disposeObject(_rewardC);
         _rewardC = null;
         ObjectUtils.disposeObject(_rewardD);
         _rewardD = null;
         ObjectUtils.disposeObject(_xImgA);
         _xImgA = null;
         ObjectUtils.disposeObject(_xImgB);
         _xImgB = null;
         ObjectUtils.disposeObject(_xImgC);
         _xImgC = null;
         ObjectUtils.disposeObject(_xImgD);
         _xImgD = null;
         ObjectUtils.disposeObject(_rewardNumA);
         _rewardNumA = null;
         ObjectUtils.disposeObject(_rewardNumB);
         _rewardNumB = null;
         ObjectUtils.disposeObject(_rewardNumC);
         _rewardNumC = null;
         ObjectUtils.disposeObject(_rewardNumD);
         _rewardNumD = null;
         ObjectUtils.disposeObject(_numberSheet);
         _numberSheet = null;
         ObjectUtils.disposeObject(_failedFlg);
         _failedFlg = null;
         ObjectUtils.disposeObject(_victoryFlg);
         _victoryFlg = null;
         ObjectUtils.disposeObject(_personRewardView);
         _personRewardView = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
      }
      
      private function addEvent() : void
      {
         _vBox.addEventListener("mouseOut",__onItemMouseOutHandler);
         _vBox.addEventListener("mouseOver",__onItemMouseOverHandler);
         _vBox.addEventListener("click",__onItemClickHandler);
         _viewRewardsBtn.addEventListener("click",__showPersonalRewardHandler);
         this.addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         if(_vBox)
         {
            _vBox.removeEventListener("mouseOut",__onItemMouseOutHandler);
            _vBox.removeEventListener("mouseOver",__onItemMouseOverHandler);
            _vBox.removeEventListener("click",__onItemClickHandler);
         }
         if(_viewRewardsBtn)
         {
            _viewRewardsBtn.removeEventListener("click",__showPersonalRewardHandler);
         }
         this.removeEventListener("response",__frameResponse);
      }
      
      private function __onItemMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleGameOverItemView = null;
         if(param1.target is FlameTempleGameOverItemView)
         {
            _loc2_ = param1.target as FlameTempleGameOverItemView;
            _loc2_.mouseOut();
         }
         else if(param1.target is TextField)
         {
            Mouse.cursor = "auto";
         }
      }
      
      private function __onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleGameOverItemView = null;
         if(param1.target is FlameTempleGameOverItemView)
         {
            _loc2_ = param1.target as FlameTempleGameOverItemView;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as FlameTempleGameOverItemView;
            Mouse.cursor = "button";
         }
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleGameOverItemView = null;
         if(param1.target is FlameTempleGameOverItemView)
         {
            _loc2_ = param1.target as FlameTempleGameOverItemView;
            selectedItem = _loc2_;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as FlameTempleGameOverItemView;
            onLinkClick(_loc2_.data);
         }
      }
      
      private function set selectedItem(param1:FlameTempleGameOverItemView) : void
      {
         if(_selectedItem)
         {
            _selectedItem.selected = false;
         }
         _selectedItem = param1;
         if(_selectedItem)
         {
            _selectedItem.selected = true;
         }
      }
      
      private function onLinkClick(param1:WarFightOrderInfo) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:String = _loc4_.serviceName;
         var _loc2_:Boolean = _loc5_ != param1.serverName;
         var _loc3_:Boolean = false;
         _menu = new ChatItemMenu(param1.nickName,param1.userId,_loc3_,param1.serverName,false,false,false,false,false);
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            if(_loc2_)
            {
               _menu.enablePlayerInfoButton(false);
            }
         }
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY + 7;
      }
      
      private function __showPersonalRewardHandler(param1:MouseEvent) : void
      {
         if(!_box)
         {
            _box = new Sprite();
            _box.x = 453;
            _box.y = -6;
            addToContent(_box);
         }
         if(_personRewardView && !_personRewardView.isDie)
         {
            onTweenCompleted();
            _personRewardView.dispose();
            _personRewardView = null;
            return;
         }
         _personRewardView = ComponentFactory.Instance.creatComponentByStylename("flameTemple.personalRewardView");
         _box.addChild(_personRewardView);
         var _loc2_:Rectangle = _personRewardView.getBounds(_personRewardView);
         _personRewardView.x = -_loc2_.x;
         _personRewardView.y = -_loc2_.y;
         _tweenRect = _box.getBounds(_box);
         _tweenRect.x = _tweenRect.width;
         updateRect();
         _tween = TweenLite.to(_tweenRect,0.6,{
            "x":0,
            "onUpdate":updateRect,
            "onComplete":onTweenCompleted
         });
      }
      
      private function updateRect() : void
      {
         if(_box)
         {
            _box.scrollRect = _tweenRect;
         }
      }
      
      private function onTweenCompleted() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
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
      
      public function show(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc4_:WarReportInfo = null;
         var _loc5_:int = 0;
         var _loc3_:WarFightOrderInfo = null;
         if(!param1)
         {
            _loc2_ = [];
            _loc4_ = new WarReportInfo();
            _loc5_ = 0;
            while(_loc5_ < 30)
            {
               _loc3_ = new WarFightOrderInfo();
               _loc3_.order = _loc5_ + 1;
               _loc3_.nickName = "阿迪达斯耐克" + _loc5_;
               _loc3_.serverName = "ajfdlaljdad";
               _loc3_.param1 = int(Math.random() * 2);
               _loc2_[_loc5_] = _loc3_;
               _loc5_++;
            }
            param1 = {
               "list":_loc2_,
               "report":_loc4_
            };
         }
         updateWithData(param1);
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function updateWithData(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc2_:FlameTempleGameOverItemView = null;
         var _loc4_:Array = param1.list;
         var _loc8_:WarReportInfo = param1.report;
         _loc4_.sortOn(["order"],[16]);
         if(_loc4_.length > 0)
         {
            _loc4_[0].isMvp = true;
         }
         ObjectUtils.disposeAllChildren(_vBox);
         _scrollPanel.beginChanges();
         var _loc3_:int = int(_loc4_.length > 8 ? _loc4_.length : 8);
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = new FlameTempleGameOverItemView();
            _loc2_.data = _loc4_[_loc7_];
            _vBox.addChild(_loc2_);
            _loc7_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         var _loc6_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:WarFightOrderInfo = null;
         for each(var _loc9_:WarFightOrderInfo in _loc4_)
         {
            if(_loc9_.userId == _loc6_.userId && _loc9_.nickName == _loc6_.nickName && _loc9_.serverName == _loc6_.serviceName)
            {
               _loc5_ = _loc9_;
               break;
            }
         }
         if(_loc5_)
         {
            NumberViewUtils.getNumberView(_loc5_.medal,_rewardNumA,_numberSheet,20,23,13,20,"0123456789",1);
            NumberViewUtils.getNumberView(_loc5_.honner,_rewardNumB,_numberSheet,20,23,13,20,"0123456789",1);
            NumberViewUtils.getNumberView(_loc5_.seniorStoreCount,_rewardNumC,_numberSheet,20,23,13,20,"0123456789",1);
            NumberViewUtils.getNumberView(_loc5_.soulsStoreCount,_rewardNumD,_numberSheet,20,23,13,20,"0123456789",1);
            _failedFlg.visible = _loc5_.teamId != _loc8_.oneTeamId;
            _victoryFlg.visible = _loc5_.teamId == _loc8_.oneTeamId;
         }
         _scoreTxt.text = _loc6_.crossScore.toString();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         onTweenCompleted();
         removeEvent();
         uintView();
         super.dispose();
         Mouse.cursor = "auto";
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
   }
}

