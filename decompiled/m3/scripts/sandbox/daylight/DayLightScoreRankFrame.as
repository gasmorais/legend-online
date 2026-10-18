package sandbox.daylight
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import mvc.controler.DayLightController;
   import sandbox.daylight.data.DayLightUserInfo;
   import sandbox.daylight.event.DayLightEvent;
   import sandbox.net.DayLightOuterManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class DayLightScoreRankFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle = new Rectangle(0,0,655,425);
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      private var _selectedItem:DayLightScoreRankItemView;
      
      private var _menu:ChatItemMenu;
      
      public function DayLightScoreRankFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         DayLightOuterManager.viewRank();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc6_:int = 0;
         var _loc2_:DayLightScoreRankItemView = null;
         titleText = LanguageMgr.GetTranslation("daylight.DayLightScoreRankFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankFrame.back");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankFrame.vBox");
         var _loc3_:Array = [LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank"),LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.title1"),LanguageMgr.GetTranslation("PvpSortListView.serverName"),LanguageMgr.GetTranslation("answer.view.rank.score"),LanguageMgr.GetTranslation("flameTempleScoreRankView.jisha")];
         var _loc4_:Array = [98,90,190,40,50,100];
         var _loc8_:Array = [0,98,188,400,510,500];
         var _loc5_:Component = new Component();
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
         _loc6_ = 0;
         while(_loc6_ < 30)
         {
            _loc2_ = new DayLightScoreRankItemView();
            _itemList.push(_loc2_);
            if(_loc6_ < 9)
            {
               _vBox.addChild(_loc2_);
            }
            _loc6_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         addToContent(_border);
         addToContent(_back);
         addToContent(_scrollPanel);
         addToContent(_loc5_);
         _vBox.mouseEnabled = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _vBox.addEventListener("mouseOut",__onItemMouseOutHandler);
         _vBox.addEventListener("mouseOver",__onItemMouseOverHandler);
         _vBox.addEventListener("click",__onItemClickHandler);
         _model.addEventListener("USER_INFO_RANK_LIST_UPDATE",__userInfoRankListUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_vBox)
         {
            _vBox.removeEventListener("mouseOut",__onItemMouseOutHandler);
            _vBox.removeEventListener("mouseOver",__onItemMouseOverHandler);
            _vBox.removeEventListener("click",__onItemClickHandler);
         }
         if(_model)
         {
            _model.removeEventListener("USER_INFO_RANK_LIST_UPDATE",__userInfoRankListUpdateHandler);
         }
      }
      
      private function __onItemMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightScoreRankItemView = null;
         if(param1.target is DayLightScoreRankItemView)
         {
            _loc2_ = param1.target as DayLightScoreRankItemView;
            _loc2_.mouseOut();
         }
         else if(param1.target is TextField)
         {
            Mouse.cursor = "auto";
         }
      }
      
      private function __onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightScoreRankItemView = null;
         if(param1.target is DayLightScoreRankItemView)
         {
            _loc2_ = param1.target as DayLightScoreRankItemView;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as DayLightScoreRankItemView;
            Mouse.cursor = "button";
         }
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DayLightScoreRankItemView = null;
         if(param1.target is DayLightScoreRankItemView)
         {
            _loc2_ = param1.target as DayLightScoreRankItemView;
            if(_selectedItem)
            {
               _selectedItem.selected = false;
            }
            _selectedItem = _loc2_;
            _selectedItem.selected = true;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as DayLightScoreRankItemView;
            onLinkClick(_loc2_.data);
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
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __userInfoRankListUpdateHandler(param1:DayLightEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc1_:DayLightScoreRankItemView = null;
         var _loc2_:int = 9;
         var _loc4_:int = 0;
         var _loc3_:Vector.<DayLightUserInfo> = _model.userRankList;
         _vBox.removeAllChild();
         if(_loc3_)
         {
            _loc3_.sort(sortRankList);
            if(_loc3_.length > 9)
            {
               _loc2_ = int(_loc3_.length);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = _loc5_ + 1;
            _loc1_ = _itemList[_loc5_] as DayLightScoreRankItemView;
            if(_loc1_)
            {
               if(_loc3_ && _loc5_ < _loc3_.length)
               {
                  _loc3_[_loc5_].order = _loc4_;
                  _loc1_.data = _loc3_[_loc5_];
               }
               else
               {
                  _loc1_.data = null;
               }
               _vBox.addChild(_loc1_);
            }
            _loc5_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function sortRankList(param1:DayLightUserInfo, param2:DayLightUserInfo) : int
      {
         if(param1.score > param2.score)
         {
            return -1;
         }
         if(param1.score < param2.score)
         {
            return 1;
         }
         if(param1.repelCount > param2.repelCount)
         {
            return -1;
         }
         if(param1.repelCount < param2.repelCount)
         {
            return 1;
         }
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         Mouse.cursor = "auto";
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

