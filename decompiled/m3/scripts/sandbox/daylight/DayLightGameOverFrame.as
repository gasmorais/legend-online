package sandbox.daylight
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
   import mvc.controler.DayLightController;
   import sandbox.daylight.data.DayLightUserInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.NumberViewUtils;
   
   public class DayLightGameOverFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle = new Rectangle(0,0,475,505);
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bottom:Component;
      
      private var _rewardBack:DisplayObject;
      
      private var _rewardLabel:Image;
      
      private var _viewRewardsBtn:TextButton;
      
      private var _rewardA:Image;
      
      private var _xImgA:Bitmap;
      
      private var _rewardNumA:Component;
      
      private var _numberSheet:BitmapData;
      
      private var _failedFlg:Bitmap;
      
      private var _victoryFlg:Bitmap;
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      private var _selectedItem:DayLightGameOverItemView;
      
      private var _menu:ChatItemMenu;
      
      private var _personRewardView:Frame;
      
      private var _tweenRect:Rectangle;
      
      private var _tween:TweenLite;
      
      private var _box:Sprite;
      
      public function DayLightGameOverFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc1_:FilterFrameText = null;
         titleText = LanguageMgr.GetTranslation("daylight.DayLightGameOverFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.back");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.vBox");
         var _loc3_:Array = [LanguageMgr.GetTranslation("PvpHeroFrame.PlayerName"),LanguageMgr.GetTranslation("PvpSortListView.serverName"),LanguageMgr.GetTranslation("daylight.DayLightGameOverFrame.scoreTitleTxt"),LanguageMgr.GetTranslation("flameTempleScoreRankView.jisha")];
         var _loc4_:Array = [116,90,70,70,40];
         var _loc8_:Array = [0,130,220,290,365];
         var _loc5_:Component = new Component();
         _loc5_.x = 6;
         _loc5_.y = 12;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankFrame.titleTxt");
            _loc1_.width = _loc4_[_loc7_];
            _loc1_.x = _loc8_[_loc7_];
            _loc1_.text = _loc3_[_loc7_];
            _loc5_.addChild(_loc1_);
            _loc7_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         addToContent(_border);
         addToContent(_back);
         addToContent(_scrollPanel);
         addToContent(_loc5_);
         _bottom = new Component();
         _bottom.x = 1;
         _bottom.y = 310;
         _rewardBack = ComponentFactory.Instance.creat("asset.daylight.RankBottom");
         _rewardLabel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.rewardLabel");
         _viewRewardsBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.viewRewardsBtn");
         _rewardA = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverFrame.rewardC");
         var _loc6_:BitmapData = ClassUtils.CreatInstance("asset.pvpmap.SymbolAsset");
         _xImgA = new Bitmap(_loc6_);
         _xImgA.x = _rewardA.x + _rewardA.width;
         _xImgA.y = 55;
         _rewardNumA = new Component();
         _rewardNumA.x = _xImgA.x + _xImgA.width - 5;
         _rewardNumA.y = 52;
         _bottom.addChild(_rewardBack);
         _bottom.addChild(_rewardLabel);
         _bottom.addChild(_viewRewardsBtn);
         _bottom.addChild(_rewardA);
         _bottom.addChild(_xImgA);
         _bottom.addChild(_rewardNumA);
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
         _vBox.mouseEnabled = false;
         _viewRewardsBtn.text = LanguageMgr.GetTranslation("daylight.DayLightGameOverFrame.viewAllRewards");
         _failedFlg.visible = false;
         _victoryFlg.visible = false;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2060801);
         if(_loc2_ != null)
         {
            _rewardA.tipData = _loc2_.TemplateName + "";
         }
      }
      
      private function uninitView() : void
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
         ObjectUtils.disposeObject(_viewRewardsBtn);
         _viewRewardsBtn = null;
         ObjectUtils.disposeObject(_rewardA);
         _rewardA = null;
         ObjectUtils.disposeObject(_xImgA);
         _xImgA = null;
         ObjectUtils.disposeObject(_rewardNumA);
         _rewardNumA = null;
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
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _vBox.addEventListener("mouseOut",__onItemMouseOutHandler);
         _vBox.addEventListener("mouseOver",__onItemMouseOverHandler);
         _vBox.addEventListener("click",__onItemClickHandler);
         _viewRewardsBtn.addEventListener("click",__showPersonalRewardHandler);
         addEventListener("response",__frameResponse);
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
         removeEventListener("response",__frameResponse);
      }
      
      private function __onItemMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightGameOverItemView = null;
         if(param1.target is DayLightGameOverItemView)
         {
            _loc2_ = param1.target as DayLightGameOverItemView;
            _loc2_.mouseOut();
         }
         else if(param1.target is TextField)
         {
            Mouse.cursor = "auto";
         }
      }
      
      private function __onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightGameOverItemView = null;
         if(param1.target is DayLightGameOverItemView)
         {
            _loc2_ = param1.target as DayLightGameOverItemView;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as DayLightGameOverItemView;
            Mouse.cursor = "button";
         }
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightGameOverItemView = null;
         if(param1.target is DayLightGameOverItemView)
         {
            _loc2_ = param1.target as DayLightGameOverItemView;
            selectedItem = _loc2_;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as DayLightGameOverItemView;
            onLinkClick(_loc2_.data);
         }
      }
      
      private function set selectedItem(param1:DayLightGameOverItemView) : void
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
      
      private function onLinkClick(param1:DayLightUserInfo) : void
      {
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:String = _loc4_.serviceName;
         var _loc2_:Boolean = _loc5_ != param1.serverName;
         var _loc3_:Boolean = false;
         _menu = new ChatItemMenu(param1.nickName,param1.userId,_loc3_,param1.serverName,false,false,false,false);
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
         _personRewardView = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardFrame");
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function refreshView() : void
      {
         var _loc7_:int = 0;
         var _loc2_:DayLightGameOverItemView = null;
         var _loc3_:int = 8;
         var _loc4_:Vector.<DayLightUserInfo> = _model.resultRankList;
         if(_loc4_)
         {
            _loc4_.sort(sortRankList);
            if(_loc4_.length > 0)
            {
               _loc4_[0].isMvp = true;
            }
            if(_loc4_.length > 8)
            {
               _loc3_ = int(_loc4_.length);
            }
         }
         ObjectUtils.disposeAllChildren(_vBox);
         _scrollPanel.beginChanges();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = new DayLightGameOverItemView();
            if(_loc4_ && _loc7_ < _loc4_.length)
            {
               _loc2_.data = _loc4_[_loc7_];
            }
            else
            {
               _loc2_.data = null;
            }
            _vBox.addChild(_loc2_);
            _loc7_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         var _loc6_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:DayLightUserInfo = null;
         var _loc1_:int = 0;
         if(_loc4_)
         {
            for each(var _loc8_:DayLightUserInfo in _loc4_)
            {
               if(_loc8_.userId == _loc6_.userId && _loc8_.nickName == _loc6_.nickName && _loc8_.serverName == _loc6_.serviceName)
               {
                  _loc5_ = _loc8_;
                  break;
               }
            }
         }
         if(_loc5_)
         {
            if(_loc5_.isReward)
            {
               _loc1_ = getRewardCount(_loc5_.order);
            }
            NumberViewUtils.getNumberView(_loc1_,_rewardNumA,_numberSheet,20,23,13,20,"0123456789",1);
            _failedFlg.visible = _loc5_.team != _model.winTeam;
            _victoryFlg.visible = _loc5_.team == _model.winTeam;
         }
      }
      
      private function getRewardCount(param1:int) : int
      {
         var _loc3_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Array = DayLightModel.PERSONAL_REWARDS;
         var _loc2_:int = int(_loc6_.length);
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc6_[_loc5_];
            if(param1 <= _loc3_.idx)
            {
               _loc4_ = int(_loc3_.count);
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function sortRankList(param1:DayLightUserInfo, param2:DayLightUserInfo) : int
      {
         if(param1.order < param2.order)
         {
            return -1;
         }
         if(param1.order > param2.order)
         {
            return 1;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         Mouse.cursor = "auto";
         onTweenCompleted();
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

